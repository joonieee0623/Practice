# pip install sqlalchemy
import pandas as pd
import sqlalchemy

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
print(df)
#print(df.dtypes)
