from sqlalchemy.orm import Session
from sqlalchemy import desc
from . import models, schemas

def insert_reboard(db: Session, reboard: schemas.ReboardCreate):
    db_item = models.Reboard(**reboard.model_dump())
    db.add(db_item)
    db.commit()
    db.refresh(db_item)
    return db_item

def update_reboard(db: Session, idx: int, reboard: schemas.ReboardUpdate):
    db_item = db.query(models.Reboard).filter(models.Reboard.idx == idx).first()
    if not db_item:
        return None
    for key, value in reboard.model_dump().items():
        setattr(db_item, key, value)
    db.commit()
    db.refresh(db_item)
    return db_item

def delete_reboard(db: Session, idx: int):
    db_item = db.query(models.Reboard).filter(models.Reboard.idx == idx).first()
    if not db_item:
        return False
    db.delete(db_item)
    db.commit()
    return True

def get_reboard(db: Session, idx: int):
    return db.query(models.Reboard).filter(models.Reboard.idx == idx).first()

def get_all_reboards(db: Session):
    return db.query(models.Reboard).order_by(desc(models.Reboard.idx)).all()

# name 은 '정확히 일치'
def get_by_name(db: Session, name: str):
    return (
        db.query(models.Reboard)
        .filter(models.Reboard.name == name)
        .order_by(desc(models.Reboard.idx))
        .all()
    )

# subject, content 는 "부분 일치(like '%...%')"
def get_by_subject(db: Session, subject: str):
    return (
        db.query(models.Reboard)
        .filter(models.Reboard.subject.like(f"%{subject}%"))
        .order_by(desc(models.Reboard.idx))
        .all()
    )

def get_by_content(db: Session, content: str):
    return (
        db.query(models.Reboard)
        .filter(models.Reboard.content.like(f"%{content}%"))
        .order_by(desc(models.Reboard.idx))
        .all()
    )
