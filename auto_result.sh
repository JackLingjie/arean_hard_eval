#!/bin/bash  
  
set -x

python show_result_ta.py  --output text --judge-name gpt-4o_text --bench-name arena-ta

python show_result_ta.py  --output image --judge-name gpt-4o_images --bench-name arena-ta
