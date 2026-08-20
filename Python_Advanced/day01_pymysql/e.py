import pymysql

HOST = '127.0.0.1'
PORT = 3306
DATABASE = 'python_schema'
USER = 'scott'
PASSWORD = 'tiger'
TNAME = 'jdbct'

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


sql = f'select * from {TNAME} order by no desc'
cursor.execute(sql)

#1-1. ftechall() 사용
rows = cursor.fetchall()
print('(1) 순방향 출력')
print('-'*40)
for row in rows:
    print(f'{row[0]}\t{row[1]}\t{row[2]}\t')

#1-2. 역방향
print('(2) 역방향 출력')
print('-'*40)
for row in reversed(rows):
    print(f'{row[0]}\t{row[1]}\t{row[2]}\t')

#2. fetchone() 사용
print('(3) 한 행씩 출력')
cursor.execute(sql)
print('-'*40)
while True:
    row = cursor.fetchone()
    if row == None: break
    print(f'{row[0]}\t{row[1]}\t{row[2]}\t')


#3. fetchmany() 사용
print('(4) n 행씩 출력')
cursor.execute(sql)
print('-'*40)
while True:
    rows = cursor.fetchmany(3)
    if not rows:
        break
    else:
        input('다음 페이지를 보려면 Enter!')
    for row in rows:
        print(f'{row[0]}\t{row[1]}\t{row[2]}\t')


cursor.close()
con.close()