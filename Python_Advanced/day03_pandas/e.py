import pandas as pd

# (1) 읽기
df = pd.read_json('day03_pandas/자료실/data.json')
#print(df)
#print(df.to_string())

df.set_index('Calories', inplace=True)
print(df)

# (2) 쓰기
df.to_excel('day03_pandas/자료실/output/data_json.xlsx')
df.to_csv('day03_pandas/자료실/output/data_json,csv')
