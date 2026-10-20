from pydantic import BaseModel, ConfigDict, Field
from datetime import datetime
from typing import Optional

# 컬럼 길이(reboard 테이블)와 맞춰 검증 → 초과 시 DB 오류(500) 대신 422 응답
class ReboardBase(BaseModel):
    name: str = Field(..., max_length=20)
    subject: str = Field(..., max_length=40)
    content: str = Field(..., max_length=50)

class ReboardCreate(ReboardBase):
    pass

class ReboardUpdate(ReboardBase):
    pass

class ReboardResponse(ReboardBase):
    # Pydantic v2 방식: 클래스 속성으로 직접 지정 (class Config 안에 넣으면 적용되지 않음)
    # orm_mode = True 는 v1 방식
    model_config = ConfigDict(from_attributes=True)

    idx: int
    regdate: Optional[datetime] = None
