#!/bin/bash

bash job_infer/job_2/infer_0.sh &
bash job_infer/job_2/infer_1.sh &
bash job_infer/job_2/infer_2.sh &
bash job_infer/job_2/infer_3.sh &
# bash bash_script/job_eval_5/eval_gpqa_3.sh | tee -a /mnt/lingjiejiang/reason/results/eval_logs_2/eval_gpqa_2.log &

wait
echo "All jobs completed."
