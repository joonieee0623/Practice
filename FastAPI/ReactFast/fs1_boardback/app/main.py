from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from .database import Base, engine
from . import routes

Base.metadata.create_all(bind=engine)

app = FastAPI(title="FastAPI Reboard API")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Spring의 @CrossOrigin("*") 대응
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(routes.router)
