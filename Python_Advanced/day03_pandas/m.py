import pymysql
import pandas as pd

HOST = '127.0.0.1'
PORT = 3306
DATABASE = 'python_schema'
USER = 'scott'
PASSWORD = 'tiger'
TNAME = 'jdbct'
sql = f'select * from {TNAME} order by no'

try:
    con = pymysql.connect(
        host = HOST,
        port = PORT,
        database = DATABASE,
        user = USER,
        password=PASSWORD,
        charset='utf8mb4'
    )
    print('MariaDB 연결 성공')
    cursor = con.cursor()
except pymysql.Error as e:
    print('MariaDB 연결실패')

cursor.execute(sql)
rows = cursor.fetchall()

#print(cursor.description)

#columns = []
#for desc in cursor.description:
#    columns.add(desc[0])
columns = [desc[0] for desc in cursor.description]
#print(columns)

df1 = pd.DataFrame(rows, columns=columns)
print(df1)
#print(df.dtypes)

cursor.close()
con.close()
