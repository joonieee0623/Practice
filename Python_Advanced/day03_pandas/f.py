import pandas as pd

# (1) 읽기
df = pd.read_excel("day03_pandas/자료실/data.xlsx", engine="openpyxl")
print(df)

# (2) 조작
df.set_index('Duration', inplace=True) #Duration 열을 index로 지정
print(df)

# (3) 쓰기
df.to_csv('day03_pandas/자료실/output/data_csv.xlsx')