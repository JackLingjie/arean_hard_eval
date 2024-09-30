#!/bin/bash  
set -x
# 参数列表  
PARAMS=(  
  "Meta-Llama-3.1-8B-Instruct"
  "Meta-Llama-3.1-70B-Instruct"
  "Qwen2-72B-Instruct"
  "tulu-2-dpo-70b"
  # 添加更多参数  
)  

LOG_FILE="evaluation_log"  
counter=0

# 遍历模型列表，生成新的文件名  
for model in "${PARAMS[@]}"; do 
    if [ $counter -ge 3 ]; then  
        break  
    fi
    # 拼接模型名到log_file后  
    LOG_FILE="${LOG_FILE}_${model}"  

    counter=$((counter + 1)) 
done  
  
# 最终的文件名  
LOG_FILE="./eval_logs/${LOG_FILE}_ta_text_images.txt"   
> $LOG_FILE
# 遍历参数列表  
for PARAM in "${PARAMS[@]}"; do  
    # 记录开始时间  
  start_time=$(date +%s)

  echo "执行参数: $PARAM" | tee -a $LOG_FILE  
  bash eval_script/ta_text_image_both_auto_arena_8b.sh $PARAM | tee -a $LOG_FILE  

    # 计算运行时间  
  elapsed_time=$((end_time - start_time))  
  elapsed_minutes=$(echo "scale=2; $elapsed_time / 60" | bc)  
      
    # 记录运行时间到日志文件  
  echo "运行时间: $elapsed_minutes 分钟" | tee -a $LOG_FILE  
  echo "----------------------------------------" | tee -a $LOG_FILE  
  sleep 20
done  

bash auto_result.sh
echo "所有任务已完成。" | tee -a $LOG_FILE  
