#!/bin/bash  
set -x  
  
# 默认模型名称和超参数  
DEFAULT_MODEL_NAME="Meta-Llama-3.1-8B-Instruct"  
DEFAULT_HYPERPARAMETER="fullft_lr5e6_e3"  
DEFAULT_CHECKPOINT="checkpoint-8500"  
  
# 检查是否传入了参数，如果没有则使用默认值  
MODEL_NAME=${1:-$DEFAULT_MODEL_NAME}  
HYPERPARAMETER=${2:-$DEFAULT_HYPERPARAMETER}  
CHECKPOINT=${3:-$DEFAULT_CHECKPOINT}  
  
# 模板文件列表  
TEMPLATE_FILES=(  
  "config/config_template/api_config_template_fullft.yaml"  
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
  sed -i "s/{{HYPERPARAMETER}}/${HYPERPARAMETER}/g" "$OUTPUT_FILE"  
  sed -i "s/{{CHECKPOINT}}/${CHECKPOINT}/g" "$OUTPUT_FILE"
done  
  
# 检查文件是否存在  
if [ -f "data/arena-hard-v0.1/model_answer/${MODEL_NAME}.jsonl" ]; then  
  echo "文件 data/arena-hard-v0.1/model_answer/${MODEL_NAME}.jsonl 存在，跳过 vllm 服务启动和 gen_answer.py 执行。"  
else  
  # 继续执行后续的指令  
  nohup vllm serve /mnt/lingjiejiang/textual_aesthetics/exp/saves/${MODEL_NAME}/${HYPERPARAMETER}/sft/${CHECKPOINT} --dtype auto --api-key token-abc123 > vllm_service.log 2>&1 &  
  
  # 获取 vllm 服务的进程 ID (PID)  
  VLLM_PID=$!  
  
  # 检查端口以确认服务是否已启动  
  HOST="0.0.0.0"  
  PORT=8000  
  TIMEOUT=600  # 超时时间（秒）  
  INTERVAL=10  # 检查间隔（秒）  
  
  echo "等待 vllm 服务启动..."  
  
  for ((i=0; i<=$TIMEOUT; i+=$INTERVAL)); do  
    if curl -s "http://$HOST:$PORT" > /dev/null; then  
      echo "vllm 服务已启动。"  
      break  
    fi  
    sleep $INTERVAL  
  done  
  
  # 检查是否超时  
  if (( i >= TIMEOUT )); then  
    echo "vllm 服务启动超时，退出..."  
    kill $VLLM_PID  
    exit 1  
  fi  
  
  python gen_answer.py  
  
  # 关闭 vllm 服务  
  kill $VLLM_PID  
  
  # 确保 vllm 服务已停止  
  wait $VLLM_PID  
fi  
  
python gen_judgment.py  
python show_result.py --output --judge-name gpt-4o  
  
# 关闭 vllm 服务  
kill $VLLM_PID  
  
# 确保 vllm 服务已停止  
wait $VLLM_PID  
  
echo
