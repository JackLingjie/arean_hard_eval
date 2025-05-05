#!/bin/bash  
  
# 设置 CUDA 可见设备  
export CUDA_VISIBLE_DEVICES=2  
  
echo eval_${CUDA_VISIBLE_DEVICES}.log
# 传入的多个模型路径（按数组形式传入）  
MODEL_PATHS=(  
    "/mnt/lingjiejiang/reason/exp/qwen2.5_math1.5b/model_qwen_math_7b_11500ckpt_sft_selected_math_100k_code_87k_science_90k_ratio0_3/checkpoint-926/"
    "/mnt/lingjiejiang/reason/exp/qwen2.5_math1.5b/model_qwen_math_7b_11500ckpt_sft_selected_math_100k_code_87k_science_90k_ratio0_3/checkpoint-500/"
    "/mnt/lingjiejiang/reason/exp/qwen2.5_math1.5b/model_qwen_math_7b_11500ckpt_sft_selected_math_100k_code_87k_science_90k_277k/checkpoint-1000/"
    "/mnt/lingjiejiang/reason/exp/qwen2.5_math1.5b/model_qwen_math_7b_11500ckpt_sft_selected_math_100k_code_87k_science_90k_277k/checkpoint-500/"
    "/mnt/lingjiejiang/reason/exp/qwen2.5_math1.5b/mix_qwen-math-7B_math835k_x2_5_openmath265k_x3_code845k_x4_science567k_x3_glan2_1750k_filter_empty_x1_packing_lr2e4/checkpoint-9500/"
    "/mnt/lingjiejiang/reason/exp/qwen2.5_math1.5b/mix_qwen-math-7B_math835k_x2_5_openmath265k_x3_code845k_x4_science567k_x3_glan2_1750k_filter_empty_x1_packing_lr2e4/checkpoint-9000/"
)  
  
# 定义 Prompt 类型（你可以根据需要修改这个变量）  
PROMPT_TYPE="qwen_nothink"  
  
# 设置最大 tokens  
MAX_TOKENS=35000  
# MAX_TOKENS=100  
# 设置温度（根据需要可以修改）  
TEMPERATURE=0.6  
  
# 提示处理的模型信息  
echo "Processing models..."  
  
# 循环处理每个模型路径  
for MODEL_NAME_OR_PATH in "${MODEL_PATHS[@]}"; do  
    # 从路径中提取模型 ID（拼接模型路径并加上 checkpoint 数字）  
    MODEL_ID=$(echo "$MODEL_NAME_OR_PATH" | sed -E 's#/.*/exp/qwen2.5_math1.5b/(.*)/checkpoint-([0-9]+)/#\1_\2#')  
  
    # 创建输出目录，拼接上 PROMPT_TYPE, TEMPERATURE, MAX_TOKENS  
    OUTPUT_DIR="/mnt/lingjiejiang/reason/results/eval_results_openr1/${MODEL_ID}_prompt_${PROMPT_TYPE}_t${TEMPERATURE}_mt${MAX_TOKENS}"  
    mkdir -p "$OUTPUT_DIR"  
  
    # 输出正在处理的模型  
    echo "Running eval for model: $MODEL_ID, checkpoint: $MODEL_NAME_OR_PATH, saved at $OUTPUT_DIR"  
  
    # 执行评估脚本  
    bash eval_script/arean_hard_reason_infer_sft.sh "$MODEL_ID" "$MODEL_NAME_OR_PATH" "$MAX_TOKENS" "$TEMPERATURE" "$PROMPT_TYPE" | tee -a eval_${CUDA_VISIBLE_DEVICES}.log  
done  