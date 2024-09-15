import random  
import time  
import threading  
from azure.identity import DefaultAzureCredential, get_bearer_token_provider  
from openai import AzureOpenAI  
import openai  

API_INFOS = [  
    {  
        "endpoints": "https://readinswedencentral.openai.azure.com/",  
        "speed": 150,  
        "model": "gpt-4"  
    },  
    {  
        "endpoints": "https://conversationhubaustraliaeast.openai.azure.com/",  
        "speed": 150,  
        "model": "gpt-4"  
    },  
    {  
        "endpoints": "https://conversationhubswedencentral.openai.azure.com/",  
        "speed": 150,  
        "model": "gpt-4"  
    }  
]  
  
class Openai():  
    _lock = threading.Lock()  
    _current_api_index = 0  
  
    def __init__(self, apis, identity_id="18731b9d-0488-49be-bb05-6ccb08f78cf3"):  
        self.identity_id = identity_id  
        flag = True  
        while flag:  
            try:  
                self.token_provider = get_bearer_token_provider(  
                    DefaultAzureCredential(managed_identity_client_id=self.identity_id),  
                    "https://cognitiveservices.azure.com/.default"  
                )  
                flag = False  
                break  
            except:  
                continue  
          
        self.apis = apis  
        self.client = self._create_client(self.apis[self._current_api_index])  
        self.model = self.apis[self._current_api_index]['model']  
  
    def _create_client(self, api_info):  

        return AzureOpenAI(  
            azure_endpoint=api_info['endpoints'],  
            azure_ad_token_provider=self.token_provider,  
            api_version="2024-04-01-preview",  
            max_retries=0,  
        )  
  
    @classmethod  
    def _update_client_index(cls):  
        with cls._lock:  
            print(f"_current_api_index:{cls._current_api_index}")
            cls._current_api_index = (cls._current_api_index + 1) % len(API_INFOS)  
            return cls._current_api_index  
  
    def _update_client(self):  
        new_index = self._update_client_index()  
        selected_api = self.apis[new_index]  
        self.client = self._create_client(selected_api)  
        self.model = selected_api['model']  
  
    def get_response(self, messages, temperature=0, max_tokens=64):  
 
        max_retry = 5  
        cur_retry = 0  
        while cur_retry <= max_retry:  
            try:  
                completion = self.client.chat.completions.create(  
                    model=self.model,  
                    messages=messages,  
                    temperature=temperature,  
                    max_tokens=max_tokens,  
                    frequency_penalty=0,  
                    presence_penalty=0,  
                    stop=None  
                )  
                results = completion.choices[0].message.content  
                self._update_client()  # 每次成功调用后更新API端点  
                return results  
            except openai.RateLimitError as e:  
                time.sleep(1)  
            except Exception as e:  
                print(e)  
                cur_retry += 1  
        self._update_client()  # 如果所有重试都失败，也要更新API端点  
        return ""  
  
    def call(self, content, client_index=None):  
        messages = [  
            {"role": "system", "content": "You are a helpful assistant."},  
            {"role": "user", "content": [  
                {"type": "text", "text": f"{content}\n"},  
            ]}  
        ]  
        return self.get_response(messages, temperature=0.0, max_tokens=64)  
  
if __name__ == '__main__':  
    
    content = "你是gpt几？"  
    messages = [  
        {"role": "system", "content": "You are a helpful assistant."},  
        {"role": "user", "content": [  
            {"type": "text", "text": f"{content}\n"},  
        ]}  
    ]  
    for i in range(10):
        oai_clients = Openai(apis=API_INFOS)  
        res = oai_clients.get_response(messages)  
        print(res)  
