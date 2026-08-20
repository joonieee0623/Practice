# 주제 : 서울시에서 학원이 가장 많은 동네 TOP10 

# 1. lib 불러오기

import pymysql
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# 2. data 불러오기

df = pd.read_excel('Python_Advanced/분석및시각화 개인미션/자료실/sample.xlsx')

# 2-1. 샘플 저장(원본 data가 너무 커서 만듦)
#df.head(1000).to_excel('Python_Advanced/분석및시각화 개인미션/자료실/sample.xlsx', index=False)
#print('샘플 저장 완료')

# 3. 분석 데이터 조작 및 가공

edu = df[df['상권업종대분류명'] == '교육']
edu = edu[['시군구명', '행정동명']]
edu.columns = ['gu', 'dong']
#print(f'교육업종: {edu.shape}')

# 4. MariaDB 접속 정보

HOST = '127.0.0.1'
PORT = 3306
DATABASE = 'python_schema'
USER = 'scott'
PASSWORD = 'tiger'
TNAME = 'seoul_academy'

# 5. MariaDB 연결

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
    print(f'예외발생: {e}')

# 6. 함수 정의

def create_table():
    sql = f'''create table if not exists {TNAME}(
        gu varchar(50),
        dong varchar(50))'''
    cursor.execute(sql)
    print(f'{TNAME} 테이블 생성 성공')

def drop_table():
    sql = f'drop table if exists {TNAME}'
    cursor.execute(sql)
    print(f'{TNAME} 테이블 삭제 성공')

def insert_data(rows):
    sql = f"insert into {TNAME} values(%s, %s)"
    result = cursor.executemany(sql, rows)
    con.commit() 
    print(f'{result}개의 row 입력 성공')

def select_top10():
    sql = f'''select gu, dong, count(*) as cnt
        from {TNAME}
        group by gu, dong
        order by cnt desc
        limit 10'''
    return pd.read_sql(sql, con)

# 7. table 생성 및 data insert

#drop_table()
#create_table()

#rows = edu.values.tolist()
#insert_data(rows)

# 8. 조회

top10 = select_top10()
print(top10)

# 9. DB 연결 종료

cursor.close()
con.close()

print('연결 종료')

# 10. 시각화

# 한글 font 설정 -- AI 도움 받음
plt.rcParams['font.family'] = 'Malgun Gothic'
plt.rcParams['axes.unicode_minus'] = False
'''
axes : 좌표 영역(x축,y축, 눈금 등)
unicode_minus : - 기호를 유니코드 방식으로 표시할지 여부를 결정(음수기호 깨짐 방지)
'''

mylabels = top10['gu']+ ' ' + top10['dong']

f1 = {'family':'Malgun Gothic', 'color':'blue', 'size':17}
f2 = {'family':'Malgun Gothic', 'color':'gray', 'size':14}

sns.barplot(x = top10['cnt'], y = mylabels)
#sns.pointplot(x = top10['cnt'], y = mylabels)

plt.title('<서울시 학원 밀집 동네 TOP10>', fontdict=f1)
plt.xlabel('학원 수', fontdict=f2)
plt.ylabel('동', fontdict=f2)
plt.grid(axis='x') #세로줄

plt.show()