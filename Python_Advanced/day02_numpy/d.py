import numpy as np

a = np.array([1,2,3,4,5])
print(a[2] + a[4])
print()

b = np.array([[1,2,3],[4,5,6]])
print(b)
print(b[1,2]) #6
print(b[1,-2]) #5

c = np.array([[[1,2],[3,4],[5,6],[7,8]]]) #3차원
print(c)
print(c[0,1,0]) #3

