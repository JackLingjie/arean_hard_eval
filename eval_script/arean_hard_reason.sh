#!/bin/bash  
set -x  
  
# 检查参数数量  
if [ "$#" -lt 4 ] || [ "$#" -gt 6 ]; then  
    echo "Usage: $0 MODEL OUTPUT_DIR MAX_NEW_TOKENS TEMPERATURE [PROMPT_TYPE] [SEED]"  
    exit 1  
fi  
  
# 从命令行参数获取值  
MODEL_NAME=$1  
MODEL_PATH=$2  
MAX_NEW_TOKENS=$3  
TEMPERATURE=$4  
PROMPT_TYPE=${5:-default}  # 如果没有传入 PROMPT_TYPE
SEED=${6:-1234}  # 如果没有传入 SEED，则使用默认值42  

# # 默认模型名称  
# DEFAULT_MODEL_NAME="Meta-Llama-3.1-8B-Instruct"  
  
# # 检查是否传入了参数，如果没有则使用默认值  
# MODEL_NAME=${1:-$DEFAULT_MODEL_NAME}  
SAVE_MODEL_ID="${MODEL_NAME}_prompt_${PROMPT_TYPE}_t${TEMPERATURE}_mt${MAX_NEW_TOKENS}_seed${SEED}"  

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
  sed -i "s/{{MODEL_NAME}}/${SAVE_MODEL_ID}/g" "$OUTPUT_FILE"  
done 

  
# 检查文件是否存在  
if [ -f "/mnt/lingjiejiang/reason/results/arena_hard/model_answer/${SAVE_MODEL_ID}.jsonl" ]; then  
  echo "文件 /mnt/lingjiejiang/reason/results/arena_hard/model_answer/${SAVE_MODEL_ID}.jsonl 存在，跳过 vllm 服务启动和 gen_answer.py 执行。"  
else  
  python gen_answer_reason.py \
    --model-path "$MODEL_PATH" \
    --model-name "$SAVE_MODEL_ID" \
    --max_new_tokens $MAX_NEW_TOKENS \
    --temperature $TEMPERATURE \
    --prompt_type $PROMPT_TYPE \
    --seed $SEED
fi 
 
python gen_judgment.py  
python show_result.py  --output --judge-name gpt-4o

# 关闭 vllm 服务  
kill $VLLM_PID  
  
# 确保 vllm 服务已停止  
wait $VLLM_PID  
  
echo "所有任务已完成，vllm 服务已关闭。"