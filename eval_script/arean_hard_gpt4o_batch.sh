#!/bin/bash  
  
set -x

# 默认模型名称  
DEFAULT_MODEL_NAME="Meta-Llama-3.1-8B-Instruct"  
  
# 检查是否传入了参数，如果没有则使用默认值  
MODEL_NAME=${1:-$DEFAULT_MODEL_NAME}  
  
# 模板文件列表  
TEMPLATE_FILES=(
  "config/config_template/api_config_template.yaml" 
  "config/config_template/gen_answer_config_template.yaml" 
  "config/config_template/judge_config_template.yaml"
)  
  
# 生成的文件列表  
FILES=(
  "config/api_config.yaml" 
  "config/gen_answer_config.yaml" 
  "config/judge_config.yaml"
)  
  
# 遍历模板文件列表并生成新的文件  
for i in "${!TEMPLATE_FILES[@]}"; do  
  TEMPLATE_FILE="${TEMPLATE_FILES[$i]}"  
  OUTPUT_FILE="${FILES[$i]}"  
    
  # 从模板文件复制到目标文件  
  cp "$TEMPLATE_FILE" "$OUTPUT_FILE"  
    
  # 在目标文件中进行替换  
  sed -i "s/{{MODEL_NAME}}/${MODEL_NAME}/g" "$OUTPUT_FILE"  
done 

  
# 检查文件是否存在  
if [ -f "data/arena-hard-v0.1/model_answer/${MODEL_NAME}.jsonl" ]; then  
  echo "文件 data/arena-hard-v0.1/model_answer/${MODEL_NAME}.jsonl 存在，跳过 vllm 服务启动和 gen_answer.py 执行。"  
else  
  python gen_answer_batch.py --model-name ${MODEL_NAME} 
fi 
 
python gen_judgment.py  
python show_result.py  --output --judge-name gpt-4o

# 关闭 vllm 服务  
kill $VLLM_PID  
  
# 确保 vllm 服务已停止  
wait $VLLM_PID  
  
echo "所有任务已完成，vllm 服务已关闭。"