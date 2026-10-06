import requests
from datetime import datetime
from zoneinfo import ZoneInfo

# 도시 이름 -> 시간대(타임존) 이름
CITY_TIMEZONES = {
    "seoul": "Asia/Seoul",
    "tokyo": "Asia/Tokyo",
    "beijing": "Asia/Shanghai",
    "shanghai": "Asia/Shanghai",
    "hong kong": "Asia/Hong_Kong",
    "singapore": "Asia/Singapore",
    "bangkok": "Asia/Bangkok",
    "dubai": "Asia/Dubai",
    "london": "Europe/London",
    "paris": "Europe/Paris",
    "berlin": "Europe/Berlin",
    "rome": "Europe/Rome",
    "moscow": "Europe/Moscow",
    "new york": "America/New_York",
    "los angeles": "America/Los_Angeles",
    "chicago": "America/Chicago",
    "toronto": "America/Toronto",
    "sydney": "Australia/Sydney",
}

#OpenAI Tools 형식으로 호출되는 함수
def tool_time(city:str):
    zone = CITY_TIMEZONES.get(city.strip().lower())
    if zone is None:
        return {"error": f"tool_time() error: '{city}' 도시는 지원하지 않습니다."}

    now = datetime.now(ZoneInfo(zone))

    return {
        "city": city.strip().title(),
        "date": now.strftime("%Y-%m-%d"),
        "time": now.strftime("%H:%M:%S"),
        "timezone": zone
    }

# OpenAI Tools JSON Schema //함수 호출 인터페이스 정의서
tool_time_spec = {
    "type": "function",
    "name": "tool_time",
    "description": "city 이름을 받아 해당 도시의 현재 날짜와 시각을 반환합니다.",
    "parameters": {
        "type": "object",
        "properties": {
            "city": {
                "type": "string",
                "description": "영문 도시명 (예: Seoul, Tokyo, New York)"
            }
        },
        "required": ["city"]
    }
}


# ===== 도구 2: 코인 시세 (업비트 공개 API, 키 불필요) =====

# 코인 이름/심볼 -> 업비트 마켓 코드
COIN_MARKETS = {
    "bitcoin": "KRW-BTC", "btc": "KRW-BTC",
    "ethereum": "KRW-ETH", "eth": "KRW-ETH",
    "ripple": "KRW-XRP", "xrp": "KRW-XRP",
    "dogecoin": "KRW-DOGE", "doge": "KRW-DOGE",
    "solana": "KRW-SOL", "sol": "KRW-SOL",
    "cardano": "KRW-ADA", "ada": "KRW-ADA",
}

#OpenAI Tools 형식으로 호출되는 함수
def tool_coin_price(coin:str):
    market = COIN_MARKETS.get(coin.strip().lower())
    if market is None:
        return {"error": f"tool_coin_price() error: '{coin}' 코인은 지원하지 않습니다."}

    res = requests.get(
        "https://api.upbit.com/v1/ticker",
        params={"markets": market},
        timeout=10
    )
    if res.status_code != 200:
        return {"error": f"tool_coin_price() error: {res.status_code}"}

    data = res.json()[0]

    return {
        "coin": coin.strip().upper(),
        "market": market,
        "price_krw": data["trade_price"],
        "change_rate_percent": round(data["signed_change_rate"] * 100, 2)
    }

# OpenAI Tools JSON Schema //함수 호출 인터페이스 정의서
tool_coin_price_spec = {
    "type": "function",
    "name": "tool_coin_price",
    "description": "코인 이름을 받아 업비트 기준 현재 원화(KRW) 시세와 전일 대비 등락률을 반환합니다.",
    "parameters": {
        "type": "object",
        "properties": {
            "coin": {
                "type": "string",
                "description": "영문 코인 이름 또는 심볼 (예: Bitcoin, BTC, Ethereum, XRP)"
            }
        },
        "required": ["coin"]
    }
}
