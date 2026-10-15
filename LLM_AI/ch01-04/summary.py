from openai import OpenAI
from dotenv import load_dotenv
import os

load_dotenv()
api_key = os.getenv('OPENAI_API_KEY')

def summarize_txt(file_path: str):
    client = OpenAI(api_key=api_key)

    with open(file_path, 'r', encoding='utf-8') as f:
        txt = f.read()


    system_prompt = f'''
    너는 다음 글을 요약하는 봇이다. 사용자가 주는 글을 읽고, 저자의 문제 인식과 주장을 파악하고, 
    원문에 없는 정보는 추측하지 말고 '정보 없음'이라고 써라.
    작성해야 하는 포맷은 다음과 같다. 이 포맷 외의 내용은 출력하지 마라.
    
    # 제목
    ## 저자의 문제 인식 및 주장
    ## 주요 내용
    ## 저자 소개
    '''
    #print(system_prompt)
    #print('===================================')

    response = client.chat.completions.create(
        model="gpt-4o-mini",
        temperature= 0.1,
        messages=[
            {"role":"system", "content": system_prompt},
            {"role":"user", "content": txt},
        ]
    )

    return response.choices[0].message.content

if __name__ == '__main__':
    file_path = 'output/2024 통계로 보는 우리나라 노동시장의 모습(PDF)_with_preprocessing.txt'
    
    summary = summarize_txt(file_path)
    print(summary)

    with open('output/labor_market_summary.txt', 'w', encoding='utf-8') as f:
        f.write(summary)