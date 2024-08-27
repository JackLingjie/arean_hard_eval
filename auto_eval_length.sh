#!/bin/bash  
set -x
# 参数列表  
PARAMS=(  
    # "tulu_v2_8b_2048_default_template_sft" 
    # "tulu_v2_8b_4096_default_template" 
    "tulu_v2_8b_2048_default_template_dpo" 
  # 添加更多参数  
)  


# 原始日志文件名  
LOG_FILE="evaluation_log"  
  
# 遍历模型列表，生成新的文件名  
for model in "${PARAMS[@]}"; do  
    # 拼接模型名到log_file后  
    LOG_FILE="${LOG_FILE}_${model}"  
done  
  
# 最终的文件名  
LOG_FILE="./eval_logs/${LOG_FILE}.txt" 

# 清空日志文件  
> "$LOG_FILE" 

# 遍历参数列表  
for PARAM in "${PARAMS[@]}"; do  
  echo "执行参数: $PARAM" | tee -a $LOG_FILE  
  bash eval_script/arean_hard.sh $PARAM | tee -a $LOG_FILE  
  echo "----------------------------------------" | tee -a $LOG_FILE  
  sleep 60
done  

echo "所有任务已完成。" | tee -a $LOG_FILE  
