from vllm import LLM, SamplingParams
from tqdm import tqdm
import datasets
import json
import argparse 

parser = argparse.ArgumentParser(description='Set model name.')  
parser.add_argument('--model-name', type=str, required=True, help='Name of the model to use')  
parser.add_argument('--model-path', type=str, default="/mnt/lingjiejiang/textual_aesthetics/model_checkpoint/sft_merge_checkpoints", help='Dir of the model to use') 
args = parser.parse_args()  
path_dir = args.model_path
model_name = args.model_name 

# template = "{{ '<|begin_of_text|>' }}{% if messages[0]['role'] == 'system' %}{% set system_message = messages[0]['content'] %}{% endif %}{% if system_message is defined %}{{ '<|start_header_id|>system<|end_header_id|>\n\n' + system_message + '<|eot_id|>' }}{% endif %}{% for message in messages %}{% set content = message['content'] %}{% if message['role'] == 'user' %}{{ '<|start_header_id|>user<|end_header_id|>\n\n' + content + '<|eot_id|><|start_header_id|>assistant<|end_header_id|>\n\n' }}{% elif message['role'] == 'assistant' %}{{ content + '<|eot_id|>' }}{% endif %}{% endfor %}"
template = "{% if messages[0]['role'] == 'system' %}{% set system_message = messages[0]['content'] %}{% endif %}{% if system_message is defined %}{{ system_message + '\n' }}{% endif %}{% for message in messages %}{% set content = message['content'] %}{% if message['role'] == 'user' %}{{ 'Human: ' + content + '\nAssistant:' }}{% elif message['role'] == 'assistant' %}{{ content + '<|end_of_text|>' + '\n' }}{% endif %}{% endfor %}"

# model_name = "Meta-Llama-3.1-8B-Instruct"
# model_name = "Meta-Llama-3.1-8B"
# Create an LLM.
llm = LLM(model=f"{path_dir}/{model_name}", trust_remote_code=True)

print(f"model name: {model_name}")
print(f"model_path: {path_dir}/{model_name}")

gen_kwargs_vllm = {
    "max_tokens": 2048,
    "temperature": 0.0,
}
tokenizer = llm.get_tokenizer()
if tokenizer.chat_template is None:
    tokenizer.chat_template = template
    # tokenizer.chat_template = tokenizer.chat_template.replace("<|eot_id|>", tokenizer.eos_token)
    # tokenizer.chat_template
    gen_kwargs_vllm['stop_token_ids'] = [tokenizer.eos_token_id, tokenizer.convert_tokens_to_ids("<|eot_id|>")]
    print(f"tokenizer.chat_template: {tokenizer.chat_template}")
    print("tokenizer is None, use setted template")
else:
    gen_kwargs_vllm['stop_token_ids'] = [tokenizer.eos_token_id, tokenizer.convert_tokens_to_ids("<|end_of_text|>")]
    print("use original template")
# messages = tokenizer.apply_chat_template(messages, tokenize=False)


sampling_params = SamplingParams(**gen_kwargs_vllm)

# 加载question.jsonl数据集  
questions = datasets.load_dataset('json', data_files='data/arena-ta/question.jsonl')['train']  

def convert_to_message(example):  
    messages = [{"role": "user", "content": example["turns"][0]['content']}]  
    example["messages"] = tokenizer.apply_chat_template(messages, tokenize=False, add_generation_prompt=True)  
    return example  
questions = questions.map(convert_to_message)  

# 生成输出  
encoded_inputs = tokenizer.batch_encode_plus(  
    questions['messages'],  
    add_special_tokens=False,
) 
input_ids = encoded_inputs['input_ids']  
# 生成输出  
outputs = llm.generate(prompt_token_ids=input_ids, sampling_params=sampling_params)
outputs_text = [x.outputs[0].text for x in outputs]  
token_lens = [len(x.outputs[0].token_ids) for x in outputs]
# 移除现有的 'output' 列并添加新的 'output' 列  
questions = questions.remove_columns(["messages"])  
questions = questions.add_column("output", outputs_text)  
questions = questions.add_column("token_lens", token_lens) 

# 定义转换函数  
def transform_example(example):  
    content = example['output']  
    # tokenized = tokenizer(content)  
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
        # "tstamp": time.time()  
    }  
    return transformed_example  
  
# 对数据集进行转换  
transformed_dataset = questions.map(transform_example, remove_columns=questions.column_names)  
  
# 保存为 JSONL 格式  
with open(f'./data/arena-ta/model_answer/{model_name}.jsonl', 'w', encoding='utf-8') as f:  
    for example in transformed_dataset:  
        json.dump(example, f)  
        f.write('\n')  
  
print(f"Data saved to ./data/arena-ta/model_answer/{model_name}.jsonl")  
 