import pandas as pd

print('pandas의 버전:', pd.__version__)

ds = {
    'animals':['tiger', 'lion', 'rabbit'],
    'count':[4,8,3]
}

a = pd.DataFrame(ds)
print(a)
print(type(a))

