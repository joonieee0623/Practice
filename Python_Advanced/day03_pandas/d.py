import pandas as pd

#(1) 읽기
df = pd.read_csv('day03_pandas/자료실/data.csv')
# print(df) #header(앞)5줄, tailer(뒤)5줄
#print(df.to_string()) #전체출력

print(pd.options.display.max_rows)  #현재 display되는 최대 row갯수 설정(default:60)
#pd.options.display.max_rows = 169  #총 row갯수가 169개이므로 모두 출력(default:169)
pd.options.display.max_rows = 168   #총 row갯수(169개)보다 적으므로 header와 tailer로 나눠 출력(default:168)
#print(df)
print(df.head(10))
print()
print(df.tail(10))
print()

print(df.head()) # head의 기본값은 5개
print()
print(df.tail()) # tail의 기본값은 5개
print()

print(df.info()) #DBMS의 desc와 비슷한 결과
print()

df.set_index('Duration', inplace=True) #Duration열을 index로 지정
print(df)

#(2) 쓰기
df.to_excel('day03_pandas/자료실/output/data_csv.xlsx')
# pip install openpyxl
# 자료실/output 폴더 생성 후 실행
