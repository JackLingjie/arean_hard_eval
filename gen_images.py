import os
from text2img import text_to_image
import concurrent.futures  
from tqdm import tqdm
def process_item(item, data_dir):  
    question_id = item["question_id"]  
    answers = item['choices'][0]['turns'][0]['content']
    model_id = item["model_id"]
    output_img = f"image_{question_id}.png"  
    data_dir = "data/images"
    text_to_image(answers, output_img, save_dir=model_id, data_dir=data_dir, temp_dir="original_temp")  


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
# model_name = 'Meta-Llama-3.1-8B-Instruct'
# baseline_model = 'gpt4_1106_preview'
# generate_answer_images()


if __name__ == "__main__":
    from utils import load_model_answers
    answer_dir = 'data/alpaca/model_answer'
    model_answers = load_model_answers(answer_dir)
    print(f"model_answers.keys() {model_answers.keys()}")
    model_name = 'Meta-Llama-3.1-8B-Instruct'
    baseline_model = 'gpt4_1106_preview'
    generate_answer_images(model_answers, model_name, baseline_model)