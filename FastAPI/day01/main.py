from fastapi import FastAPI, status
from pydantic import BaseModel

app = FastAPI()

# 서버 실행
@app.get("/")
def root_handler():
    return {"message": "Hello, FastAPI!"}

@app.get("/login")
def login_handler():
    return {"message": "로그인 페이지에 오신 것을 환영합니다."}

@app.get("/users/{user_id}")
def user_handler(user_id: int):
    return {"user_id": user_id, "message":f"사용자 {user_id} 정보 조회"}

@app.get("/items")
def read_items_handler(max_price: int | None = None):
    return {"max_price": max_price}

class Item(BaseModel):
    name: str
    price: int
    in_stock: bool  = True

@app.put("/items/{item_id}")
def update_item_handler(item_id: int, assignee: str, item: Item):
    return{
        "item_id": item_id,
        "assignee": assignee,
        "item": item,
    }

@app.post("/items", status_code=status.HTTP_201_CREATED)
def create_item_handler(item: Item):
    return {"message": f"아이템 '{item.name}'이(가) 추가되었습니다.", "item": item}
