#!/bin/bash  
  
set -x  
  
# 默认模型名称和超参数  
DEFAULT_MODEL_NAME="Meta-Llama-3.1-8B-Instruct"  
DEFAULT_HYPERPARAMETER="fullft_lr5e6_e3"  
DEFAULT_STAGE="sft"  
DEFAULT_CHECKPOINT="checkpoint-8500"  
  
# 检查是否传入了参数，如果没有则使用默认值  
MODEL_NAME=${1:-$DEFAULT_MODEL_NAME}  
HYPERPARAMETER=${2:-$DEFAULT_HYPERPARAMETER}  
STAGE=${3:-$DEFAULT_STAGE}  
CHECKPOINT=${4:-$DEFAULT_CHECKPOINT}  
  
# 模板文件列表  
TEMPLATE_FILES=(  
  "config/config_template/api_config_template_fullft.yaml"  
  "config/config_template/gen_answer_config_template_fullft.yaml"  
  "config/config_template/judge_config_template_fullft.yaml"  
)  
  
# 生成的文件列表  
FILES=(  
  "config/api_config.yaml"  
  "config/gen_answer_config.yaml"  
  "config/judge_config.yaml"  
)  
  
# 拼接新的 model-path  
MODEL_PATH="/mnt/lingjiejiang/textual_aesthetics/exp/saves/${MODEL_NAME}/${HYPERPARAMETER}/${STAGE}/${CHECKPOINT}"  
SAVE_MODEL_ID="${MODEL_NAME}_${CHECKPOINT}"  
echo $SAVE_MODEL_ID  
  
# 遍历模板文件列表并生成新的文件  
for i in "${!TEMPLATE_FILES[@]}"; do  
  TEMPLATE_FILE="${TEMPLATE_FILES[$i]}"  
  OUTPUT_FILE="${FILES[$i]}"  
  
  # 从模板文件复制到目标文件  
  cp "$TEMPLATE_FILE" "$OUTPUT_FILE"  
  
  # 在目标文件中进行替换  
  sed -i "s/{{SAVE_MODEL_ID}}/${SAVE_MODEL_ID}/g" "$OUTPUT_FILE"  
  sed -i "s/{{MODEL_NAME}}/${MODEL_NAME}/g" "$OUTPUT_FILE"  
  sed -i "s/{{HYPERPARAMETER}}/${HYPERPARAMETER}/g" "$OUTPUT_FILE"  
  sed -i "s/{{CHECKPOINT}}/${CHECKPOINT}/g" "$OUTPUT_FILE"  
done  
  
# 检查文件是否存在  
if [ -f "data/arena-hard-v0.1/model_answer/${SAVE_MODEL_ID}.jsonl" ]; then  
  echo "文件 data/arena-hard-v0.1/model_answer/${SAVE_MODEL_ID}.jsonl 存在，跳过 vllm 服务启动和 gen_answer.py 执行。"  
else  
  python gen_answer_batch_ft.py \
    --model-path "$MODEL_PATH" \
    --model-name "$SAVE_MODEL_ID"  
fi  
  
python gen_judgment.py  
python show_result.py  --output --judge-name gpt-4o

