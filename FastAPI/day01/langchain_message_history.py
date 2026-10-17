from langchain_core.chat_history import InMemoryChatMessageHistory, BaseChatMessageHistory
from langchain_core.runnables.history import RunnableWithMessageHistory
from langchain_openai import ChatOpenAI     # 오픈AI 모델을 사용하는 랭체인 챗봇 클래스 
from langchain_core.messages import HumanMessage
from dotenv import load_dotenv
load_dotenv()

model = ChatOpenAI(model="gpt-4o-mini")

store = {}

# 세션 ID에 따라 대화 기록을 가져오는 함수
def get_session_history(session_id: str) -> BaseChatMessageHistory:
    # 만약 해당 세션 ID가 store에 없으면, 새로 생성해 추가
    if session_id not in store:
        store[session_id] = InMemoryChatMessageHistory()
        # 메모리에 대화 기록을 저장하는 객체 생성
    return store[session_id]
    # 해당 세션의 대화 기록을 반환

# 모델 실행 시 대화 기록을 함께 전달하는 래퍼 객체 생성
with_message_history = RunnableWithMessageHistory(model, get_session_history)


config = {"configurable": {"session_id":"abc2"}}
# 세션ID를 생성하는 config 객체 생성

response = with_message_history.invoke(
    [HumanMessage(content="안녕? 난 주원이야.")],
    config=config,              # 같은 session_id "abc2"-> 이전 대화 기억
)

print(response.content)


config2 = {"configurable": {"session_id": "abc3"}}
response = with_message_history.invoke(
    [HumanMessage(content="내 이름이 뭐라고 했지?")],
    config=config2,        # 새 session_id → 처음 보는 사람 취급
)
print(response.content)


config3 = {"configurable": {"session_id": "abc4"}}
response = with_message_history.invoke(
    [HumanMessage(content="아까 우리가 무슨 얘기 했지?")],
    config=config3,
)
print(response.content)
