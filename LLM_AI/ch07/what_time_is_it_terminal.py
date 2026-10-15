from gpt_functions import get_current_time, tools
from openai import OpenAI
from dotenv import load_dotenv
import os
import json     # GPT가 JSON 형태의 문자열을 반환할 때 읽기 위한 라이브러리 임포트
import streamlit as st

load_dotenv()
api_key = os.getenv("OPENAI_API_KEY")

client = OpenAI(api_key=api_key)

def get_ai_response(messages, tools=None):
    response = client.chat.completions.create(
        model="gpt-4o",
        messages=messages,
        tools=tools,
    )
    return response

st.title("Chatbot")

if "messages" not in st.session_state:
    st.session_state["messages"] = [
        {"role": "system", "content": "너는 사용자를 도와주는 상담사야."},
    ]

for msg in st.session_state.messages:
    if msg["role"] in ("user", "assistant") and msg.get("content"):    # 사용자/AI 메시지만 화면에 표시
        st.chat_message(msg["role"]).write(msg["content"])

if user_input := st.chat_input():
    st.session_state.messages.append({"role":"user", "content": user_input})
    st.chat_message("user").write(user_input)

    ai_response = get_ai_response(st.session_state.messages, tools=tools)
    ai_message = ai_response.choices[0].message
    print(ai_message)

    tool_calls = ai_message.tool_calls          # AI 응답에 포함된 tool_calls 가져오기
    if tool_calls:                              # tool_calls가 있는 경우
        st.session_state.messages.append(ai_message.model_dump(exclude_none=True))  # dict로 바꿔서 한 번만 추가

        for tool_call in tool_calls:
            tool_name = tool_call.function.name     # 실행해야 한다고 판단한 함수명 받기
            tool_call_id = tool_call.id             # 함수 아이디 받기
            arguments = json.loads(tool_call.function.arguments)

            if tool_name == "get_current_time":     # tool_name이 "get_current_time"인 경우
                st.session_state.messages.append({
                    "role": "tool",                 # tool_call_id를 쓰려면 role은 "tool"
                    "tool_call_id": tool_call_id,
                    "content": get_current_time(timezone=arguments['timezone']),
                })
        st.session_state.messages.append({"role": "system", "content": "이제 주어진 결과를 바탕으로 답변할 차례다."})

        ai_response = get_ai_response(st.session_state.messages, tools=tools)   # 함수 결과를 바탕으로 다시 답변 받기
        ai_message = ai_response.choices[0].message

    st.session_state.messages.append({
         "role" : "assistant", "content" : ai_message.content})

    print("AI\t: " + ai_message.content)
    st.chat_message("assistant").write(ai_message.content)

