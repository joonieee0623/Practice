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
    print(f'(1) MariaDB 연결 성공: {con}')
    con.close()
    print('(2) MariaDB 연결 성공')
    
except pymysql.Error as e:
    print(f'예외발생: MariaDB 연결 성공: {e}')


