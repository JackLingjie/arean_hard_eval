import transformers  
import torch  
from tqdm import tqdm  
import datasets  
import json  
import argparse  
  
# Argument parsing  
parser = argparse.ArgumentParser(description='Set model name.')  
parser.add_argument('--model-name', type=str, required=True, help='Name of the model to use')  
parser.add_argument('--model-path', type=str, default="/mnt/lingjiejiang/textual_aesthetics/model_checkpoint/sft_merge_checkpoints", help='Dir of the model to use')  
args = parser.parse_args()  
  
path_dir = args.model_path  
model_name = args.model_name  
  
# Load the tokenizer and model  
tokenizer = transformers.AutoTokenizer.from_pretrained(path_dir, trust_remote_code=True)  
model = transformers.AutoModelForCausalLM.from_pretrained(path_dir, trust_remote_code=True, torch_dtype=torch.bfloat16)  
model.to("cuda")  
  
print(f"model name: {model_name}")  
print(f"model_path: {path_dir}")  
  
gen_kwargs_hf = {  
    "max_new_tokens": 2048,  
    "temperature": 0.0,  
    "do_sample": False,  
}  
gen_kwargs_hf['eos_token_id'] = [tokenizer.eos_token_id, tokenizer.convert_tokens_to_ids("<|end_of_text|>")]  
gen_kwargs_hf['pad_token_id'] = tokenizer.eos_token_id  
  
def generate_response(prompt):  
    inputs = tokenizer(prompt, return_tensors="pt", add_special_tokens=False).to(model.device)  
    tokens = model.generate(**inputs, **gen_kwargs_hf)  
    prompt = prompt.replace("<|begin_of_text|>", "")  
    return tokenizer.decode(tokens[0], skip_special_tokens=True).replace(prompt, '')  
  
# Load dataset  
questions = datasets.load_dataset('json', data_files='data/arena-hard-v0.1/question.jsonl')['train']  
  
# Convert dataset examples to messages  
def convert_to_message(example):  
    messages = [{"role": "user", "content": example["turns"][0]['content']}]  
    example["messages"] = tokenizer.apply_chat_template(messages, tokenize=False, add_generation_prompt=True)  
    return example  
  
questions = questions.map(convert_to_message)  
  
# Generate responses  
outputs_text = []  
token_lens = []  
for example in tqdm(questions):  
    response = generate_response(example['messages'])  
    outputs_text.append(response)  
    token_lens.append(len(tokenizer.encode(response)))  
  
# Update dataset with model outputs  
questions = questions.remove_columns(["messages"])  
questions = questions.add_column("output", outputs_text)  
questions = questions.add_column("token_lens", token_lens)  
  
# Define transformation function  
def transform_example(example):  
    content = example['output']  
    token_len = example['token_lens']  
    transformed_example = {  
        "question_id": example['question_id'],  
        "answer_id": example['question_id'],  
        "model_id": model_name,  
        "choices": [  
            {  
                "index": 0,  
                "turns": [  
                    {  
                        "content": content,  
                        "token_len": token_len  
                    }  
                ]  
            }  
        ],  
    }  
    return transformed_example  
  
# Transform dataset  
transformed_dataset = questions.map(transform_example, remove_columns=questions.column_names)  
  
# Save to JSONL format  
with open(f'data/arena-hard-v0.1/model_answer/{model_name}.jsonl', 'w', encoding='utf-8') as f:  
    for example in transformed_dataset:  
        json.dump(example, f)  
        f.write('\n')  
  
print(f"Data saved to data/arena-hard-v0.1/model_answer/{model_name}.jsonl")  