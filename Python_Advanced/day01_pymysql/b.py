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


def create_table():
    sql = f'''create table if not exists {TNAME}(
        no int primary key,
        name varchar(10),
        rdate datetime)'''
    cursor.execute(sql)
    print(f'{TNAME} 테이블 생성 성공')

create_table()

def drop_table():
    sql = f'drop table if exists {TNAME}'
    cursor.execute(sql)
    print(f'{TNAME} 테이블 삭제 성공')

def insert_row(no, name):
    sql = f"insert into {TNAME} values('{no}', '{name}', sysdate())"
    result = cursor.execute(sql)
    con.commit() #DML후 commit
    if result>0:
        print(f'{result}개의 row 입력 성공')
    else:
        print('입력 실패')

#insert_row(10, '홍길동')
#insert_row(20, '이순신')
#insert_row(30, '강감찬')
#insert_row(40, '유관순')

def update_row(no, name):
    sql = f"update {TNAME} set name = '{name}' where no={no}"
    result = cursor.execute(sql)
    con.commit() 
    if result>0:
            print(f'{result}개의 row 입력 수정 성공')
    else:
            print('수정 실패')


#update_row(30, '을지문덕')


def delete_row(no):
    sql = f"delete from {TNAME} where no={no}"
    result=cursor.execute(sql)
    con.commit()
    if result>0:
        print(f'{result}개의 row 삭제 성공')
    else:
        print('삭제 실패')

#delete_row(20)

def select_all():
    sql = f'select * from {TNAME} order by no desc'
    cursor.execute(sql)
    rows = cursor.fetchall() # list type으로 반환
    print('번호\t이름\t날짜')
    print('-' * 40)
    for row in rows:
        no, name, rdate = row
        print(f'{no}\t{name}\t{rdate}')
    print('-' * 40)
    print(f'총{len(rows)}개의 row가 검색됨')


select_all()

cursor.close()
con.close()
print('연결 종료')