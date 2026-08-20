import pandas as pd

#잘못된 'data 포맷' 수정/삭제
df = pd.read_csv('day03_pandas/자료실/dirtydata.csv')
print(df)
print()

df.dropna(subset=['Date'], inplace=True) #22라인 NAN 삭제
print(df)
print()

df['Date'] = pd.to_datetime(df['Date'], format='mixed') #일반적인 날짜포맷으로 '수정'
print(df)
print()
