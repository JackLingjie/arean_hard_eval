#!/bin/bash  
  
# 设置 CUDA 可见设备  
export CUDA_VISIBLE_DEVICES=1  
  
echo eval_${CUDA_VISIBLE_DEVICES}.log
# 传入的多个模型路径（按数组形式传入）  
MODEL_PATHS=(  
        "/mnt/unilm/xun/reasoning/Reward_DPO/results/v1_160k/training_results/4o_dpo_160k_fullft_cut8k_lr1e-6_sigmoid_beta0.1_5epochs_bs1_ga8_dsz3/checkpoint-4000"
        "/mnt/unilm/xun/reasoning/Reward_DPO/results/v1_160k/training_results/4o_dpo_160k_fullft_cut8k_lr1e-6_sigmoid_beta0.1_5epochs_bs1_ga8_dsz3/checkpoint-4100"
        "/mnt/unilm/xun/reasoning/Reward_DPO/results/v1_160k/training_results/4o_dpo_160k_fullft_cut8k_lr1e-6_sigmoid_beta0.1_5epochs_bs1_ga8_dsz3/checkpoint-8000"
        "/mnt/unilm/xun/reasoning/Reward_DPO/results/v1_160k/training_results/4o_dpo_160k_fullft_cut8k_lr1e-6_sigmoid_beta0.1_5epochs_bs1_ga8_dsz3/checkpoint-12680"
 
        "/mnt/unilm/xun/reasoning/Reward_DPO/results/v1_160k/training_results/gpt4_dpo_160k_fullft_cut8k_lr1e-6_sigmoid_beta0.1_5epochs_bs1_ga8_dsz3/checkpoint-2900"
        "/mnt/unilm/xun/reasoning/Reward_DPO/results/v1_160k/training_results/gpt4_dpo_160k_fullft_cut8k_lr1e-6_sigmoid_beta0.1_5epochs_bs1_ga8_dsz3/checkpoint-4000"
        "/mnt/unilm/xun/reasoning/Reward_DPO/results/v1_160k/training_results/gpt4_dpo_160k_fullft_cut8k_lr1e-6_sigmoid_beta0.1_5epochs_bs1_ga8_dsz3/checkpoint-8000"
        "/mnt/unilm/xun/reasoning/Reward_DPO/results/v1_160k/training_results/gpt4_dpo_160k_fullft_cut8k_lr1e-6_sigmoid_beta0.1_5epochs_bs1_ga8_dsz3/checkpoint-8840"
)  

# 定义 Prompt 类型（你可以根据需要修改这个变量）  
PROMPT_TYPE="qwen_v1_no_sys"  
  
# 设置最大 tokens  
MAX_TOKENS=35000  
# MAX_TOKENS=100  
# 设置温度（根据需要可以修改）  
TEMPERATURE=0.6  
  
# 提示处理的模型信息  
echo "Processing models..."  
  
# 循环处理每个模型路径  
for MODEL_NAME_OR_PATH in "${MODEL_PATHS[@]}"; do  
    echo "Transform model to HuggingFace format..."
    # python bash_script/model_merge.py --local_dir "$MODEL_NAME_OR_PATH/actor/"

    # 提取 step 数字和模型主目录名组成 MODEL_ID
    CHECKPOINT_NAME=$(basename "$MODEL_NAME_OR_PATH")
    DIR_NAME=$(basename "$(dirname "$MODEL_NAME_OR_PATH")")
    MODEL_ID="${DIR_NAME}_${CHECKPOINT_NAME}"


    # 最终用于评估的模型路径，加上 /actor/huggingface/
    HF_MODEL_PATH="${MODEL_NAME_OR_PATH}"

    # 创建输出目录  
    # OUTPUT_DIR="/mnt/lingjiejiang/reason/results/arena_hard/model_answer/${MODEL_ID}_prompt_${PROMPT_TYPE}_t${TEMPERATURE}_mt${MAX_TOKENS}"  
    # mkdir -p "$OUTPUT_DIR"  

    echo "Running eval for model: $MODEL_ID"
    echo "Using HuggingFace model path: $HF_MODEL_PATH"
    echo "Results saved to: $OUTPUT_DIR"   
  
    # 执行评估脚本  
    bash eval_script/arean_hard_reason_rerun.sh "$MODEL_ID" "$HF_MODEL_PATH" "$MAX_TOKENS" "$TEMPERATURE" "$PROMPT_TYPE" | tee -a eval_${CUDA_VISIBLE_DEVICES}.log  
done  