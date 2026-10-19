import requests
from config import settings

# LLM이 호출할 함수
def tool_weather(city: str):
    url = (
        "https://api.openweathermap.org/data/2.5/weather"
        f"?q={city}&units=metric&appid={settings.OPENWEATHER_API_KEY}"
    )
    res = requests.get(url)
    if res.status_code != 200:
        return {"error": f"tool_weather() error: {res.status_code}"}

    data = res.json()
    return {
        "city": data["name"],
        "temp": data["main"]["temp"],
        "description": data["weather"][0]["description"],
    }

# 함수 설명서 (LangChain/Chat Completions 형식: function 안에 name이 있음)
tool_weather_spec = {
    "type": "function",
    "function": {
        "name": "tool_weather",
        "description": "city 이름을 받아 해당 도시의 현재 날씨 정보를 반환합니다.",
        "parameters": {
            "type": "object",
            "properties": {
                "city": {"type": "string", "description": "영문 도시명 (예: Seoul, Tokyo)"}
            },
            "required": ["city"],
        },
    },
}
