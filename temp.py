    from gpt4 import Openai, API_INFOS
    oai_client = Openai(apis=API_INFOS)
    client = Openai(apis=API_INFOS).client
    # if api_dict:
    #     print(api_dict)
    #     client = openai.OpenAI(
    #         base_url=api_dict["api_base"],
    #         api_key=api_dict["api_key"],
    #     )
    # else:
        
    #     client = openai.OpenAI()
    
    output = API_ERROR_OUTPUT
    for _ in range(API_MAX_RETRY):
        try:
            output = oai_client.get_response(
                messages=messages,
                temperature=temperature,
                max_tokens=max_tokens
                )
            # completion = client.chat.completions.create(
            #     model=model,
            #     messages=messages,
            #     temperature=temperature,
            #     max_tokens=max_tokens,
            #     )
            
            # output = completion.choices[0].message.content