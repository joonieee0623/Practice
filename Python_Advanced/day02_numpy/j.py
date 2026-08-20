import numpy as np

a = np.array([1,2,3,4,5]) #1차원
for x in a: 
    print(x)
print()

b = np.array([[1,2],[3,4]]) #2차원
for x in b:
    for y in x:
        print(y)
print()

c = np.array([[[1,2],[3,4]],[[5,6],[7,8]]]) #3차원
for x in c:
    for y in x:
        for z in y:
            print(z)
print()

### Numpy만의 강력한 메소드 ###
for x in np.nditer(c): #element만
    print(x)
print()

for i, x in np.ndenumerate(c):
    print(i, x)
print()

for i, x in np.ndenumerate(a):
    print(i, x)
print()

for i, x in np.ndenumerate(b):
    print(i, x)
print()