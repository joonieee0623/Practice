from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List, Optional
from . import crud, schemas, database

router = APIRouter(
    prefix="/reboards",
    tags=["Reboard"]
)

# 먼저 search 라우트를 등록함
@router.get("/search", response_model=List[schemas.ReboardResponse])
def search_reboards(
    name: Optional[str] = None,
    subject: Optional[str] = None,
    content: Optional[str] = None,
    db: Session = Depends(database.get_db)
):
    if name:
        return crud.get_by_name(db, name)
    elif subject:
        return crud.get_by_subject(db, subject)
    elif content:
        return crud.get_by_content(db, content)
    else:
        raise HTTPException(status_code=400, detail="검색 조건이 없습니다.")


# ✅ 이후에 개별 idx 조회
@router.get("/{idx}", response_model=schemas.ReboardResponse)
def get_reboard(idx: int, db: Session = Depends(database.get_db)):
    item = crud.get_reboard(db, idx)
    if not item:
        raise HTTPException(status_code=404, detail=f"Reboard {idx} not found")
    return item


@router.get("", response_model=List[schemas.ReboardResponse])  # 슬래시 없는 버전
@router.get("/", response_model=List[schemas.ReboardResponse])  # 기존 슬래시 있는 버전
def get_all_reboards(db: Session = Depends(database.get_db)):
    return crud.get_all_reboards(db)

@router.post("", response_model=schemas.ReboardResponse)  # 슬래시 없는 버전
@router.post("/", response_model=schemas.ReboardResponse)  # 기존 슬래시 있는 버전
def create_reboard(reboard: schemas.ReboardCreate, db: Session = Depends(database.get_db)):
    return crud.insert_reboard(db, reboard)

@router.put("/{idx}", response_model=schemas.ReboardResponse)
def update_reboard(idx: int, reboard: schemas.ReboardUpdate, db: Session = Depends(database.get_db)):
    updated = crud.update_reboard(db, idx, reboard)
    if not updated:
        raise HTTPException(status_code=404, detail=f"Reboard {idx} not found")
    return updated

@router.delete("/{idx}")
def delete_reboard(idx: int, db: Session = Depends(database.get_db)):
    deleted = crud.delete_reboard(db, idx)
    if not deleted:
        raise HTTPException(status_code=404, detail=f"Reboard {idx} not found")
    return {"result": True}
