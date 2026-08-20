import pandas as pd
import sqlalchemy

print('1. DF 생성(DB table -> df)')
print()

HOST = '127.0.0.1'
PORT = 3306
DATABASE = 'python_schema'
USER = 'scott'
PASSWORD = 'tiger'
TNAME = 'jdbct'
sql = f'select * from {TNAME} order by no'

engine = sqlalchemy.create_engine(
    f'mysql+pymysql://{USER}:{PASSWORD}@{HOST}:{PORT}/{DATABASE}?charset=utf8mb4'
)
df = pd.read_sql(sql, engine)

print('2. DF핸들링')

print(' 2-1) 컬럼추가')
df['name_len'] = df['name'].apply(len)
print(df)
print()

print(' 2-2) 조건필터링')
print(df[df['no']>=40])
print()

print('3. 조작된 DF를 DB에 저장(df -> DB)')
df_copy = df[['no', 'name', 'name_len']].copy()

df_copy.to_sql(
    name= 'jdbct2',
    con = engine,
    if_exists='replace',  #table이 있으면 덮어씀
    index=False
)
print('jdbct2 테이블에 저장 완료!')
print()

print('4. 저장된 DB table 읽기')
df_read = pd.read_sql(f'select * from jdbct2', engine)
print(df_read)
print()

print('5. 연결해제')
engine.dispose() 