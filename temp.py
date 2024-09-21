from openai import OpenAI

# Modify OpenAI's API key and API base to use vLLM's API server.
openai_api_key = "EMPTY"
openai_api_base = "http://localhost:8000/v1"
client = OpenAI(
    api_key=openai_api_key,
    base_url=openai_api_base,
)
completion = client.completions.create(model="/mnt/lingjiejiang/textual_aesthetics/exp/saves/glanchat_v2.1_8b_2048_default_template_8500_dpo/fullft/dpo/checkpoint-2756",
                                      prompt="San Francisco is a")
print("Completion result:", completion)