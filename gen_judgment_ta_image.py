import json
import yaml
import argparse
import os
import re
import concurrent.futures
from prompt_config import system_template_image as system_prompt, user_template_image as user_prompt
from tqdm import tqdm
from text2img import text_to_image
import base64
from utils import (
    load_questions,
    chat_completion_openai,
    chat_completion_openai_azure,
    chat_completion_anthropic,
    load_questions,
    load_model_answers,
    get_endpoint,
    make_config,
)
def encode_image(image_path):
    with open(image_path, "rb") as image_file:
        return base64.b64encode(image_file.read()).decode('utf-8')  
     
# def process_item(item, data_dir):  
#     question_id = item["question_id"]  
#     answers = item['choices'][0]['turns'][0]['content']
#     model_id = item["model_id"]
#     output_img = f"image_{question_id}.png"  
#     data_dir = "data/images"
#     text_to_image(answers, output_img, save_dir=model_id, data_dir=data_dir, temp_dir="original_temp")  

def process_item(item, data_dir):  
    question_id = item["question_id"]  
    answers = item['choices'][0]['turns'][0]['content']  
    model_id = item["model_id"]  
    output_img = f"image_{question_id}.png"  
      
    attempts = 0  
    max_attempts = 3  
    success = False  
  
    while attempts < max_attempts and not success:  
        attempts += 1  
        text_to_image(answers, output_img, save_dir=model_id, data_dir=data_dir, temp_dir="original_temp")  
          
        # 检查文件是否存在  
        file_path = os.path.join(data_dir, model_id, output_img)  
        if os.path.exists(file_path):  
            success = True  
        else:  
            print(f"Attempt {attempts} failed for question_id {question_id}. Retrying...")  
      
    if not success:  
        print(f"Failed to generate image for question_id {question_id} after {max_attempts} attempts.")
          
def generate_image(model_name, model_answers, data_dir):
    max_workers = 20  
    print(f"-----------------generate {model_name} images -----------------")
    total_items = len(model_answers[model_name])
    with tqdm(total=total_items, desc=f"Processing {model_name}") as progress_bar:
        with concurrent.futures.ThreadPoolExecutor(max_workers=max_workers) as executor:  
            futures = [executor.submit(process_item, model_answers[model_name][key], data_dir) for key in model_answers[model_name].keys()]  
            for future in concurrent.futures.as_completed(futures):  
                try:  
                    future.result()  
                except Exception as exc:  
                    print(f'Generated an exception: {exc}')  
                progress_bar.update(1)

def generate_answer_images(model_answers, model_name, baseline_model, data_dir='data/images'):
    if os.path.exists(os.path.join(data_dir, baseline_model)) == False:
        generate_image(baseline_model, model_answers, data_dir)
    
    #generate images
    generate_image(model_name, model_answers, data_dir)
    
    print("images generated done.")

def get_score(judgment, pattern, pairwise=True):
    matches = pattern.findall(judgment)
    matches = [m for m in matches if m != ""]
    if len(set(matches)) == 0:
        return None, True
    elif len(set(matches)) == 1:
        if pairwise:
            return matches[0].strip("\n"), False
        return int(matches[0])
    else:
        return None, False


# get answer from model
def get_answer(model, conv, temperature, max_tokens, endpoint_dict=None, index=0):
    api_dict = get_endpoint(endpoint_dict["endpoints"])

    if endpoint_dict["api_type"] == "anthropic":
        output = chat_completion_anthropic(model, conv, temperature, max_tokens)
    elif endpoint_dict["api_type"] == "azure":
        output = chat_completion_openai_azure(model, conv, temperature, max_tokens, api_dict, index)
    else:
        output = chat_completion_openai(model, conv, temperature, max_tokens, api_dict)
    return output


def judgment(**args):
    # global user_prompt
    question = args["question"]
    answer = args["answer"]
    reference = args["reference"]
    baseline = args["baseline_answer"]
    configs = args["configs"]
    output_file = args["output_file"]
    index = args["index"]
    model = configs["judge_model"]
    user_prompt = args["user_prompt"]
    system_prompt = args["system_prompt"]
    num_games = 2 if configs["pairwise"] else 1
    images_path = args["images_path"]
    baseline_model = configs["baseline_model"]
    output = {
        "question_id": question["question_id"],
        "model": answer["model_id"],
        "judge": model,
        "games": []
        }
    question_id = question["question_id"]
    image1_path = os.path.join(images_path, answer["model_id"], f"image_{question_id}.png")
    image2_path = os.path.join(images_path, baseline_model, f"image_{question_id}.png")
 
    base64_image1 = encode_image(image1_path)
    base64_image2 = encode_image(image2_path)
    template = user_prompt
    for game in range(num_games):
        conv = [{"role": "system", "content": system_prompt}]

        # for template in configs["prompt_template"]:
        # template = user_prompt
        prompt_args = {}

        for i, turn in enumerate(question["turns"]):
            # print(f"i: {i} turn: {turn}")
            prompt_args[f"question_{i+1}"] = turn["content"]
        base = 1

        if baseline:
            # print("has baseline")
            # print(f"game: {game}")
            if game % 2 == 1: # swap position
                answer, baseline = baseline, answer
                base64_image1, base64_image2 = base64_image2, base64_image1
            # for i, turn in enumerate(baseline["choices"][0]["turns"]):
            #     prompt_args[f"answer_{i+1}"] = turn["content"]
            #     base += 1
        # if answer:
        #     for i, turn in enumerate(answer["choices"][0]["turns"]):
        #         prompt_args[f"answer_{i+base}"] = turn["content"]

        # if reference:
        #     for j, ref_answer in enumerate(reference):
        #         for i, turn in enumerate(ref_answer["choices"][0]["turns"]):
        #             prompt_args[f"ref_answer_{i+j+1}"] = turn["content"]
        # print(f"prompt_args:{prompt_args}")
        # print(f"template:{template}")
        try:
            user_prompt = template.format(**prompt_args)
        except Exception as e:
            print(f"Error: {e}")
            raise e
        conv.append(
            {"role": "user", 
             "content": [
                {"type": "text", "text": f"{user_prompt}\n"},
                {
                    "image":base64_image1
                },
                {
                    "image":base64_image2
                }
                ]
            })

        judgment = ""
        for _ in range(configs['number_of_judgment_attempts']):
            new_judgment = get_answer(
                endpoint_info["model_name"],
                conv,
                configs["temperature"],
                configs["max_tokens"],
                args["endpoint_dict"],
                index
            )

            judgment += ("\n" + new_judgment)

            score, try_again = get_score(judgment, args["regex_pattern"])

            conv.append({"role": "assistant", "content": new_judgment})

            if not try_again:
                break

            conv.append({"role": "user", "content": "continue your judgment and finish by outputting a final verdict label"})
        # print(f"system prompt {system_prompt}")
        result = {
            "user_prompt": user_prompt,
            "judgment": judgment,
            "score": score
        }
        output["games"].append(result)

    with open(output_file, "a") as f:
        f.write(json.dumps(output, ensure_ascii=False) + "\n")


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--setting-file", type=str, default="config/judge_config.yaml")
    parser.add_argument("--endpoint-file", type=str, default="config/api_config.yaml")
    args = parser.parse_args()
    print(args)
    images_path = 'data/images'
    configs = make_config(args.setting_file)
    endpoint_list = make_config(args.endpoint_file)

    print(f'judge model: {configs["judge_model"]}, baseline: {configs["baseline"]}, baseline model: {configs["baseline_model"]}, reference: {configs["reference"]}, '
          + f'reference models: {configs["ref_model"]}, temperature: {configs["temperature"]}, max tokens: {configs["max_tokens"]}, pairwise: {configs["pairwise"]}')

    if configs["regex_pattern"]:
        pattern = re.compile(configs["regex_pattern"])

    question_file = os.path.join("data", configs["bench_name"], "question.jsonl")
    answer_dir = os.path.join("data", configs["bench_name"], "model_answer")
    ref_answer_dir = os.path.join("data", configs["bench_name"], "reference_answer")

    questions = load_questions(question_file)
    model_answers = load_model_answers(answer_dir)
    
    # if user choose a set of models, only judge those models
    models = [model for model in configs["model_list"]]
        
    ref_answers = None
    if configs["reference"]:
        ref_answers = load_model_answers(ref_answer_dir)
        ref_answers = [ref_answers[model] for model in configs["ref_model"]]
    
    output_files = {}
    output_dir = f"data/{configs['bench_name']}/model_judgment/{configs['judge_model']}_images"
    for model in models:
        output_files[model] = os.path.join(
            output_dir,
            f"{model}.jsonl",
        )

    for output_file in output_files.values():
        os.makedirs(os.path.dirname(output_file), exist_ok=True)

    existing_judgments = load_model_answers(output_dir)

    endpoint_info = endpoint_list[configs["judge_model"]]
    print(f"generate images {','.join(models)}")
    # NOTE(1): debug
    # for model in models:
    #     generate_answer_images(model_answers, model_name=model, baseline_model=configs["baseline_model"], data_dir='data/images')

    with concurrent.futures.ThreadPoolExecutor(max_workers=endpoint_info["parallel"]) as executor:
        futures = []
        for model in models:
            count = 0
            for idx, question in enumerate(questions):
                question_id = question["question_id"]

                kwargs = {}
                kwargs["question"] = question
                if model in model_answers and not question_id in model_answers[model]:
                    print(f"Warning: {model} answer to {question['question_id']} cannot be found.")
                    continue

                if model in existing_judgments and question_id in existing_judgments[model]:
                    count += 1
                    continue

                kwargs["answer"] = model_answers[model][question_id]
                if ref_answers:
                    kwargs["reference"] = [ref_answer[question_id] for ref_answer in ref_answers]
                    assert len(kwargs["reference"]) == len(configs["ref_model"])
                else:
                    kwargs["reference"] = None
                if configs["baseline"]:
                    kwargs["baseline_answer"] = model_answers[configs["baseline_model"]][question_id]
                else:
                    kwargs["baseline_answer"] = None
                kwargs["configs"] = configs
                kwargs["endpoint_dict"] = endpoint_info
                kwargs["output_file"] = output_files[model]
                kwargs["regex_pattern"] = pattern
                kwargs["index"] = idx
                kwargs["user_prompt"] = user_prompt
                kwargs["system_prompt"] = system_prompt
                kwargs["images_path"] = images_path
                future = executor.submit(judgment, **kwargs)
                futures.append(future)

            if count > 0:
                print(f"{count} number of existing judgments")

        for future in tqdm(
            concurrent.futures.as_completed(futures), total=len(futures)
        ):
            future.result()
