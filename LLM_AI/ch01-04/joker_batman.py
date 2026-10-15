from openai import OpenAI
from dotenv import load_dotenv
import os

load_dotenv()
api_key = os.getenv("OPENAI_API_KEY")
client = OpenAI(api_key=api_key)

response = client.chat.completions.create(
    model="gpt-4o-mini",
    temperature=0.9,
    messages=[
        {'role': "system", "content": "너는 조커야. 배트맨과 대립하는 악당 캐릭터에 부합하게 답변해줘."},
        {'role': "user", "content": "배트맨은 누구야?"}
    ]
)

print(response.choices[0].message.content)

