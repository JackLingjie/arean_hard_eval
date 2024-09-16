import os  
  
def list_directories(path, output_file):  
    with open(path, "r") as f:
        print(f.read())
  
if __name__ == "__main__":  
    # 指定要遍历的目录路径  
    directory_path = "/mnt/lingjiejiang/textual_aesthetics/model_checkpoint/sft_merge_checkpoints/uf_llama3.1_instruct_dpo_2048_job/config.json"  
    output_file_path = "output_file.txt"  
      
    list_directories(directory_path, output_file_path) 
