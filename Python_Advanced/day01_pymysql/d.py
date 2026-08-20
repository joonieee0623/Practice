import pymysql

HOST = '127.0.0.1'
PORT = 3306
DATABASE = 'python_schema'
USER = 'scott'
PASSWORD = 'tiger'


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

def call_incre2(empno, rate):
    try:
        cursor.callproc('INCRE2', (empno, rate)) #tuple
        print(f'호출 성공({empno}번 사원의 급여 {rate}% 인상 완료)')
    except pymysql.Error as e:
        print(f'INCRE2 프로시저 찾지 못했거나 호출실패 : {e}')
    finally:
        cursor.close()
        con.close()

call_incre2(7369, 20)

cursor.close()
con.close()