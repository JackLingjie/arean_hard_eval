#!/bin/bash  
set -x  
  
# 参数列表，每个元素包含model_name, hyperparameter, 和 checkpoint，用逗号分隔  
PARAMS=(  
  # "glanchat_v2.1_8b_2048_default_template,fullft_lr5e6_e3,checkpoint-8500"  
    # "glanchat_v2.1_8b_2048_default_template,fullft_lr5e6_e3,checkpoint-9918"
    # "magpie_8b_2048_default_template,fullft_lr5e6_e3,checkpoint-8500"
      # "magpie_8b_2048_default_template_dpo,fullft,dpo,checkpoint-2756"
      "magpie_dpo_v0.1_8b_2048_default_template_dpo_ckpt536,fullft,dpo,checkpoint-1529"
  # "glan_v2_glanchat_v2_8b_2048_default_template,fullft_lr5e6_e3_fx,checkpoint-33000"  
  # "Meta-Llama-3.1-8B-Instruct,fullft_lr5e6_e3,checkpoint-8500"  
  # "ta_chosen_llama3.1_instruct_dpo_2048,fullft_lr5e6_e3,checkpoint-8500"  
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
LOG_FILE="./eval_logs/${LOG_FILE}.txt"  
  
# 遍历参数列表  
for PARAM in "${PARAMS[@]}"; do  
  # 记录开始时间  
  start_time=$(date +%s)  
  
  # 将参数分割为模型名称、超参数和checkpoint  
  IFS=',' read -r model_name hyperparameter stage checkpoint <<< "$PARAM"  
  
  echo "执行参数: $model_name, $hyperparameter, $stage, $checkpoint" | tee -a $LOG_FILE    
  
  # 调用带参数的脚本  
  bash eval_script/arean_hard_fullft.sh "$model_name" "$hyperparameter" "$stage" "$checkpoint" | tee -a $LOG_FILE  
  
  # 记录结束时间  
  end_time=$(date +%s)  
  
  # 计算运行时间  
  elapsed_time=$((end_time - start_time))  
  elapsed_minutes=$(echo "scale=2; $elapsed_time / 60" | bc)  
  
  # 记录运行时间到日志文件  
  echo "运行时间: $elapsed_minutes 分钟" | tee -a $LOG_FILE  
  echo "----------------------------------------" | tee -a $LOG_FILE  
  
  sleep 60  
done  
  
echo "所有任务已完成。" | tee -a $LOG_FILE  
