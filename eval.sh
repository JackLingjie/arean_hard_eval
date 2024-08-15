## base
vllm serve /home/lidong1/jianglingjie/LLama-Factory/model_checkpoint/huggingface/Meta-Llama-3.1-8B --dtype auto --api-key token-abc123 --chat-template llama3.jinja

## instruct
vllm serve /home/lidong1/jianglingjie/LLama-Factory/model_checkpoint/huggingface/Meta-Llama-3.1-8B-Instruct --dtype auto --api-key token-abc123

python gen_answer.py

python gen_judgment.py

python show_result.py