import pandas as pd

a = [3, 1, 2, 4]

s1 = pd.Series(a)
print(s1)
print(s1[0])
print()

s2 = pd.Series(a, index=['x', 'y', 'z', 'k'])
print(s2)
print(type(s2))
print(s2['z'])

b = {'one':170, 'tw':165, 'three':185}
s3 = pd.Series(b)
print(s3)
print()

s4 = pd.Series(b, index=['one', 'two'])
print(s4)
print()