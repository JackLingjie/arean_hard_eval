import os  
  
def list_directories(path, output_file):  
    try:  
        # 打开输出文件  
        with open(output_file, 'w') as f:  
            # 遍历指定目录下的所有文件和目录  
            for item in os.listdir(path):  
                # 构造完整路径  
                full_path = os.path.join(path, item)  
                # 检查是否为目录  
                if os.path.isdir(full_path):  
                    f.write(f'"{item}"\n')  
        print(f"Directory names have been written to {output_file}")  
    except Exception as e:  
        print(f"Error: {e}")  
  
if __name__ == "__main__":  
    # 指定要遍历的目录路径  
    directory_path = "/mnt/lingjiejiang/textual_aesthetics/model_checkpoint/sft_merge_checkpoints"  
    output_file_path = "output_file.txt"  
      
    list_directories(directory_path, output_file_path) 
