# 주제 : <서울시에서 학원이 가장 많은 동네 TOP10 (샘플 1,000건)>

# 1. lib 불러오기

import pymysql
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# 2. data 불러오기

df = pd.read_excel('분석및시각화 개인미션/자료실/sample.xlsx')

# 2-1. 샘플 저장(원본 data가 너무 커서 만듦)
#df.head(1000).to_excel('분석및시각화 개인미션/자료실/sample.xlsx', index=False)
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
plt.rcParams['font.family'] = 'Malgun Gothic'  #시각화 그래프 전체 폰트를 맑은 고딕으로 지정
plt.rcParams['axes.unicode_minus'] = False
'''
1.
 - 역할 : 시각화 시 한글과 마이너스(-)기호가 깨지는 현상을 해결하기 위함
 - 필요성 : Matplotlib의 기본 폰트(DejaVu Sans 등)는 한글 글꼴을 지원하지 않는다. 
    그래서 폰트를 지정하지 않고 한글 제목이나 축 라벨을 출력하면 
    글자가 모두 네모('□')로 깨져서 나오는 '한글 폰트 깨짐 현상'이 발생한다.
- 작동 원리 : rcParams는 Matplotlib의 전체 굵기, 색상, 폰트 등 환경 설정을 담고 있는 객체.
    여기서 font.family 값을 윈도우 OS의 기본 한글 폰트인 'Malgun Gothic'으로 변경하여
    그래프 내 모든 텍스트가 한글을 정상 표현하도록 만듦.
2.
 - 역할 : 그래프 축(axes)의 음수 기호(-)에 유니코드 마이너스를 사용하지 않도록 설정
 - 필요성 : 한글 폰트(예: 맑은 고딕)를 적용하면 특수 문자인 '유니코드 마이너스 문어체(U+2212)'를 지원하지 못하는 경우가 많음
    이로 인해 그래프 축에 -10, -20 같은 음수가 들어갈 때 마이너스 기호가 깨져서 네모('□')로 뜨는 문제가 생긴다.
 - 작동 원리 : xes.unicode_minus 속성을 False로 변경하면, 유니코드 마이너스 문자 대신 
    일반 키보드 하이픈 마이너스 문자(ASCII U+002D)를 사용하여 음수를 표현한다.
    이렇게 하면 폰트 호환 문제 없이 마이너스 기호가 정상적으로 출력된다.
'''

mylabels = top10['gu']+ ' ' + top10['dong']

f1 = {'family':'Malgun Gothic', 'color':'blue', 'size':17}
f2 = {'family':'Malgun Gothic', 'color':'gray', 'size':14}

sns.barplot(x = top10['cnt'], y = mylabels)
#sns.pointplot(x = top10['cnt'], y = mylabels)

plt.title('<서울시 학원 밀집 동네 TOP10(샘플1,000건)>', fontdict=f1)
plt.xlabel('학원 수', fontdict=f2)
plt.ylabel('동', fontdict=f2)
plt.grid(axis='x') #세로줄
plt.tight_layout()

plt.savefig('분석및시각화 개인미션/결과.png')
plt.show()