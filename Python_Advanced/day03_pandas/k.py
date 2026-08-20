import pandas as pd

# 동일한 값을 가지는 row들을 제거
df = pd.read_csv('day03_pandas/자료실/dirtydata.csv')
#print(df)
#print()

#print(df.duplicated()) 
#print()

df.drop_duplicates(inplace=True) #index값을 무시
print(df)
