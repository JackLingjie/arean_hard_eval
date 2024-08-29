#!/bin/bash  
set -x
# 参数列表  
PARAMS=(  
    # "ta_chosen_tuluv2_dpo_2048_default_template"
    # "ta_chosen_llama3.1_instruct_dpo_2048"
    # "ta_rejected_llama3.1_instruct_dpo_2048" 
    "Meta-Llama-3.1-8B-Instruct"
    # "wildchat_v2_8b_2048_default_template_fullft_lr5e6_e5_9485" 
    # "wildchat_v2_8b_2048_default_template_fullft_lr5e6_3794" 
    # "wildchat_v2_8b_2048_default_template_fullft_e5_9485" 
    # "wildchat_v2_8b_2048_default_template_full_sft"
    # "wildchat_v2_8b_2048_default_template_3796"
    # "wildchat_v1_8b_2048_default_template_4000" 
  # "tulu_lora_sft_default_template_8b"
  # "tulu_v2_8b_bsz64_default_template_dpo"
  # "tulu_v2_8b_base_template_dpo"
  # 添加更多参数  
)  

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
    # 记录开始时间  
  start_time=$(date +%s)

  echo "执行参数: $PARAM" | tee -a $LOG_FILE  
  bash eval_script/arean_hard.sh $PARAM | tee -a $LOG_FILE  

    # 计算运行时间  
  elapsed_time=$((end_time - start_time))  
  elapsed_minutes=$(echo "scale=2; $elapsed_time / 60" | bc)  
      
    # 记录运行时间到日志文件  
  echo "运行时间: $elapsed_minutes 分钟" | tee -a $LOG_FILE  
  echo "----------------------------------------" | tee -a $LOG_FILE  
  sleep 60
done  

echo "所有任务已完成。" | tee -a $LOG_FILE  
