from sqlalchemy import Column, BigInteger, String, TIMESTAMP, func
from .database import Base

# reboard_maria.sql 의 테이블 정의와 일치시킴
class Reboard(Base):
    __tablename__ = "reboard"

    idx = Column(BigInteger, primary_key=True, autoincrement=True)  # bigint
    name = Column(String(20))
    subject = Column(String(40))
    content = Column(String(50))
    # 등록일: 생성 시에만 기록 (수정 시 갱신되지 않도록 onupdate 제거)
    regdate = Column(TIMESTAMP, nullable=False, server_default=func.current_timestamp())
