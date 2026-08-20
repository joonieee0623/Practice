import pandas as pd

# empty cell 채움
df = pd.read_csv('day03_pandas/자료실/dirtydata.csv')
print(df)
print()

#df.fillna(200, inplace=True) --error(문자열)
df2 = df['Calories'].fillna(200, inplace=True)
print(df2)
print()

#x = df['Calories'].mean() #평균(avg) : 304.68
#x = df['Calories'].median() #중위값(mid point) : 291.2
x = df['Calories'].mode()[0] #빈도값(most common) : 300.0
print(x)

df3 = df['Calories'].fillna(x, inplace=True)
print(df3)



