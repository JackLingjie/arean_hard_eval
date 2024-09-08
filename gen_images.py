import os
from text2img import text_to_image, text_to_image_with_timeout
import concurrent.futures  
from tqdm import tqdm
import argparse
import logging

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
    max_attempts = 5  
    success = False  
  
    while attempts < max_attempts and not success:  
        attempts += 1  
        logging.debug(f"output_img: {output_img}")
        text_to_image_with_timeout(answers, output_img, save_dir=model_id, data_dir=data_dir, temp_dir="original_temp")  
          
        # 检查文件是否存在  
        file_path = os.path.join(data_dir, model_id, output_img)  
        if os.path.exists(file_path):  
            success = True  
        else:  
            logging.debug(f"Attempt {attempts} failed for question_id {question_id}. Retrying...")  
      
    if not success:  
        logging.debug(f"Failed to generate image for question_id {question_id} after {max_attempts} attempts.")
 

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



if __name__ == "__main__":
    from utils import load_model_answers
    parser = argparse.ArgumentParser(description='Generate images from model answers.')  
    parser.add_argument('--model_name', type=str, default='Meta-Llama-3.1-8B-Instruct', help='Name of the model.')  
    parser.add_argument('--baseline_model', type=str, default='gpt4_1106_preview', help='Name of the baseline model.') 
    args = parser.parse_args() 


    answer_dir = 'data/alpaca/model_answer'
    model_answers = load_model_answers(answer_dir)
    # print(f"model_answers.keys() {model_answers.keys()}")
    # model_name = 'Meta-Llama-3.1-8B-Instruct'
    model_name = args.model_name
    baseline_model = args.baseline_model
    # baseline_model = 'gpt4_1106_preview'
    generate_answer_images(model_answers, model_name, baseline_model)