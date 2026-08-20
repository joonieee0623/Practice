import numpy as np

a = np.array([1,2,3,4,5,6,7,8,9,10,11,12]) #1차원
print(a.shape) #(12,) 원소 1개짜리 tuple
print()

a2 = a.reshape(4,3) #2차원으로 변경
print(a2)
print(a2.shape)

a3 = a.reshape(2,3,2) #3차원으로 변경
print(a3)
print(a3.shape)
print(a3.base)
print()

b = np.array([[1,2], [3,4],[5,6],[7,8]]) #2차원
b2 = b.reshape(-1) #1차원으로 변경 : 평탄화(flatten)
print(b2)
print()