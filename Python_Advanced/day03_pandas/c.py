import pandas as pd

#DataFrame : 2차원 테이블 구조
ds = {
    '칼로리':[400, 300, 350],
    '운동시간':[50, 35, 45]
}
df1 = pd.DataFrame(ds)
print(df1)
print()

# 1 index의 row를 추출
print(df1.loc[1])
print()

# 이상/이하의 row를 추출
print(df1.loc[0:1])
print()

df2 = pd.DataFrame(ds, index=["d1", "d2", "d3"])
print(df2)
print()

print(df2.loc['d2'])
print()

