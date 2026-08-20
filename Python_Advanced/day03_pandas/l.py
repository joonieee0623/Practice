import pandas as pd

#상관관계계수 (Correlations)
df = pd.read_csv('day03_pandas/자료실/data.csv')
print(df.to_string())
print()

x = df.corr() #상관관계계수
print(x)