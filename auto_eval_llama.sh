#!/bin/bash  
  
# 设置 CUDA 可见设备  
export CUDA_VISIBLE_DEVICES=0  
  
echo eval_${CUDA_VISIBLE_DEVICES}.log
# 传入的多个模型路径（按数组形式传入）  
MODEL_PATHS=(  
    "/mnt/lingjiejiang/reason/exp/qwen2.5_math1.5b/think_hybrid_llama_8b_merged_reasoning_1074k_generall_nothink_oasst2_1749k/checkpoint-40995/"

    #   "/mnt/lingjiejiang/reason/exp/qwen2.5_math1.5b/think_hybrid_qwen_15b_merged_reasoning_1074k_generall_nothink_oasst2_1749k/checkpoint-40995/"
    # "/mnt/lingjiejiang/reason/exp/qwen2.5_math1.5b/think_hybrid_math_merged_reasoning_1074k_generall_nothink_oasst2_1749k/checkpoint-40995/"

    # "/mnt/lingjiejiang/reason/exp/qwen2.5_math1.5b/think_hybrid_qwen_15b_merged_reasoning_1074k_generall_nothink_oasst2_1749k/checkpoint-40995/"
    # "/mnt/lingjiejiang/reason/exp/qwen2.5_math1.5b/qwen_1.5B_openr1_synthetic_openthought_aime_kodcode_aops_taco_cf_dedup_1074k/checkpoint-25176/"
    # "/mnt/lingjiejiang/reason/exp/qwen2.5_math1.5b/add_synthetic_openr1_openthought_aime_rej_kodcode_taco_aops_cf_1075k/checkpoint-25203/"
)  
  
# 定义 Prompt 类型（你可以根据需要修改这个变量）  
PROMPT_TYPE="llama_no_sys"  
  
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
    bash eval_script/arean_hard_reason_rerun.sh "$MODEL_ID" "$MODEL_NAME_OR_PATH" "$MAX_TOKENS" "$TEMPERATURE" "$PROMPT_TYPE" | tee -a eval_${CUDA_VISIBLE_DEVICES}.log  
done  

PROMPT_TYPE="llama_no_think"  
  
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
    bash eval_script/arean_hard_reason_rerun.sh "$MODEL_ID" "$MODEL_NAME_OR_PATH" "$MAX_TOKENS" "$TEMPERATURE" "$PROMPT_TYPE" | tee -a eval_${CUDA_VISIBLE_DEVICES}.log  
done  

PROMPT_TYPE="llama_think"  
  
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
    bash eval_script/arean_hard_reason_rerun.sh "$MODEL_ID" "$MODEL_NAME_OR_PATH" "$MAX_TOKENS" "$TEMPERATURE" "$PROMPT_TYPE" | tee -a eval_${CUDA_VISIBLE_DEVICES}.log  
done  