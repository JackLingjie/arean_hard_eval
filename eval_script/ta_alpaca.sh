python gen_answer_ta.py --model-name Meta-Llama-3.1-8B-Instruct | tee gen_answer_ta.log

python gen_judgment_ta.py | tee gen_judge.log


python show_result.py  --output --judge-name gpt-4o --bench-name alpaca
python  gen_judgment_ta_image.py | tee gen_judge.log

python gen_images.py --model_name tulu_v2_8b_2048_default_template_sft
python gen_images.py --model_name tulu_v2_8b_2048_default_template_dpo