import pandas as pd

# empty cell 제거 (정제)
df = pd.read_csv('day03_pandas/자료실/dirtydata.csv')
print(df)
print()

df2 = df.dropna() # empty cell을 가진 row들을 모두 제거해서 '새로운 df생성'
print(df2)
print()


df.dropna(inplace=True) #'원본 df'에서 empty cell을 가진 row들을 모두 제거
print(df)
