#!/bin/bash  
set -x
# 参数列表  
# conda init
# conda activate eval

PARAMS=(  
  "tulu-2-7b"  
  "tulu-2-dpo-7b"
  # 添加更多参数  
)  

# 日志文件  
LOG_FILE="eval.log"  

# 清空或创建日志文件  
> $LOG_FILE  

# 遍历参数列表  
for PARAM in "${PARAMS[@]}"; do  
  echo "执行参数: $PARAM" | tee -a $LOG_FILE  
  bash eval_script/arean_hard.sh $PARAM | tee -a $LOG_FILE  
  echo "----------------------------------------" | tee -a $LOG_FILE  
  sleep 60
done  

echo "所有任务已完成。" | tee -a $LOG_FILE  
