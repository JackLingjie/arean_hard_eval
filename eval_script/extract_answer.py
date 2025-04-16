import json
import argparse

def process_text(text):
    text = text.strip()
    if text.endswith('</no_think>'):
        if '<no_think>' in text:
            return text.replace('<no_think>', '').replace('</no_think>', '').strip()
        else:
            return text.replace('</no_think>', '').strip()
    elif '</think>' in text:
        return text.split('</think>', 1)[1].strip()
    else:
        return "format wrong"

def process_jsonl_file(file_path):
    processed_lines = []

    # 逐行读取
    with open(file_path, 'r', encoding='utf-8') as f:
        for line in f:
            item = json.loads(line)
            raw_response = item.get("raw_response", "")
            processed_text = process_text(raw_response)

            try:
                item["choices"][0]["turns"][0]["content"] = processed_text
            except (KeyError, IndexError):
                item["choices"] = [{
                    "index": 0,
                    "turns": [{
                        "content": processed_text,
                        "token_len": 0
                    }]
                }]

            processed_lines.append(item)

    # 重写写回 jsonl
    with open(file_path, 'w', encoding='utf-8') as f:
        for item in processed_lines:
            f.write(json.dumps(item, ensure_ascii=False) + '\n')

def main():
    parser = argparse.ArgumentParser(description="Update choices[0]['turns'][0]['content'] in JSONL file.")
    parser.add_argument("--json_file", type=str, required=True, help="Path to the JSONL file")
    args = parser.parse_args()

    process_jsonl_file(args.json_file)

if __name__ == "__main__":
    main()
