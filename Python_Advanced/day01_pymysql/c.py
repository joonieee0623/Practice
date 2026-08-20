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

SQL_INSERT = f"insert into {TNAME} values(%s, %s, now())"  #가독성
SQL_SEL_LIKE = f'select * from {TNAME} where name like %s' #반복실행(앞 부분은 한 번만 compile하고 -> 속도 빨라짐(효율적))

def insert_row(no, name):
    result = cursor.execute(SQL_INSERT, (no, name)) #tuple
    con.commit()
    if cursor.rowcount>0:
        print(f'{cursor.rowcount}개의 row 입력 성공')
    else:
        print('입력 실패')

insert_row(50, '홍길순')
insert_row(60, '홍길자')

def select_by_name(keyword):
    cursor.execute(SQL_SEL_LIKE, (f'%{keyword}%',))
    rows = cursor.fetchall()
    select_all(rows)

def select_all(rows):
    pass

select_by_name('홍길')

cursor.close()
con.close()