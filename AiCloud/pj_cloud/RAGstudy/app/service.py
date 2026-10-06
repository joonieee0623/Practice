from mariadb_vector_store import MariaDBVectorStore
from openai import OpenAI
from config import settings
from langchain_core.documents import Document
#import requests
from tools import tool_time, tool_time_spec, tool_coin_price, tool_coin_price_spec
import json

# 도구 이름 -> 실제 함수 (AI가 알려준 이름으로 함수를 찾아 실행)
TOOLS = {
    "tool_time": tool_time,
    "tool_coin_price": tool_coin_price,
}

class VectorService:
    def __init__(self):
        self.store = MariaDBVectorStore()
        self.client = OpenAI(api_key=settings.OPENAI_API_KEY)

    #1. 테이블 생성
    def create_table(self):
        self.store.create_table()
        return "기존 테이블 존재 or 테이블 생성 완료!"

    #2. 샘플 문서 저장
    def load_sample_docs(self):
        samples = [
            Document(
                page_content="2347년 양자 엔진이 완성되어 인류는 성간 항해에 성공했다.",
                metadata={"meta1": "info"}
            ),
            Document(
                page_content="K-17 달 식민지에서 발견된 크리스털 코어는 멸종한 문명의 기억을 담고 있었다.",
                metadata={}
            ),
            Document(
                page_content="시간은 나선이며 크로노 워커들은 다른 시간선에서 경고를 받았다.",
                metadata={"author": "john", "type": "blog"}
            )
        ]

        self.store.add_documents(samples)
        return len(samples)

        #3. RAG+FC 질문/답변
    def rag_tool_query(self, query, k=3): #rag_fc_query() -> rag_tool_query()
        #(1) 사용자 질문을 영어로 번역
        translated_query = self.translate_query_to_english(query)

        #(2) RAG 검색 실행 (translated_query로 변경)
        results = self.store.similarity_search(translated_query, k=k)

        if results is None:
            return "테이블이 존재하지 않습니다.\n먼저 '1. DB 테이블 생성'을 눌러주세요."

        #(3) 도구 2개를 AI에게 주고, 필요하면 AI가 알아서 골라 호출하게 함
        system_prompt = """
        You can use tools to get real-time information.
        - tool_time: current date and time of a city
        - tool_coin_price: current price of a cryptocurrency
        If the question needs one of them, call that tool.
        Otherwise, do NOT call any tool.
        """

        call_resp = self.client.responses.create(
            model="gpt-4o-mini",
            input=[
                {"role": "system", "content": system_prompt},
                {"role": "user", "content": translated_query}
            ],
            tools=[tool_time_spec, tool_coin_price_spec],
            tool_choice="auto"
        )

        #(4) AI가 도구 호출을 요청했으면 (responses API에서는 타입이 function_call)
        for item in call_resp.output:
            if item.type == "function_call":
                func = TOOLS.get(item.name)
                if func is None:
                    return f"알 수 없는 도구입니다: {item.name}"

                args = json.loads(item.arguments)
                tool_result = func(**args)
                print(f"@tool_result({item.name}): " + str(tool_result))

                return self.summarize_tool(item.name, tool_result) #최종자연어 답변생성

        #(5) (도구 호출이 없으면) RAG를 위한 문맥 구성과 프롬프트 작성
        if len(results) > 0:
            context = "\n\n".join(d.page_content for d in results)

            prompt = f"""
            Answer the user's question using the following documents.

            [Documents]
            {context}

            [Question]
            {query}
            """

            response = self.client.responses.create(
                model="gpt-4o-mini",
                input=prompt
            )
            return response.output_text

        return "관련 문서를 찾을 수 없습니다."

    # tool호출 결과(dict)를 자연스러운 한국어 문장으로 변환하는 함수
    def summarize_tool(self, tool_name:str, tool_result:dict):
        if "error" in tool_result:
            return tool_result["error"]

        final_prompt = f"""
        아래는 '{tool_name}' 도구가 실시간으로 조회한 결과입니다.
        이 내용만 사용해서 한국어로 자연스럽게 한두 문장으로 알려 주세요.
        숫자는 그대로 쓰고, 금액에는 '원', 등락률에는 '%'를 붙여 주세요.

        {json.dumps(tool_result, ensure_ascii=False)}
        """

        response = self.client.responses.create(
            model="gpt-4o-mini",
            input=final_prompt
        )

        return response.output_text.strip()
    
    def translate_query_to_english(self, query):
        prompt = f"""
        다음 문장을 영어로 번역하세요. 다른 설명 없이 번역된 문장만 출력하세요.
        문장: "{query}"
        """
        response = self.client.responses.create(
            model="gpt-4o-mini",
            input=prompt
        )
        return response.output_text.strip()

    def extract_location(self, query):
        prompt = f"""
        아래 문장에서 '현재 시각을 알고 싶은 도시명'만 출력하세요. 두 단어 도시명도 가능합니다(예 : New York).
        문장 : "{query}"
        출력 형식 : 도시명 단독 출력 (예 : Seoul)
        """

        response = self.client.responses.create(
            model="gpt-4o-mini",
            input=prompt
        )
        city =  response.output_text.strip()

        import re # St.John's -> St Johns
        city = re.sub(r"[^a-zA-Z\s]", "", city).strip()

        if len(city) == 0:
            return 'Seoul'

        return city
