import pandas as pd

# (1) 읽기
df = pd.read_html('day03_pandas/자료실/data.html')
print(df)
print()

print(len(df)) #찾아낸 표의 개수
print()

print(df[0]) #첫 번째 표의 행 수
print()
print(df[1]) #두 번째 표의 행 수
print()

# (2) 조작
df[0].set_index(['c0'], inplace=True)
print(df[0])
print()

df[1].set_index(['name'], inplace=True)
print(df[1])
print()

