import numpy as np

a = np.array([1,2,3,4,5,6,7,8,9,10])
print(a[1:9]) #이상 미만
print(a[3:]) #이상
print(a[:3]) #미만
print(a[-3:-1])
print(a[::2]) #step

b = np.array([[1,2,3,4],[5,6,7,8]])
print(b[1, 1:3]) # 1 index배열의 1이상 3미만 값들
print(b[0:2, 2]) # 1 index와 2 index의 1차원 배열의 2 index값들
print(b[:, 2]) # 모든 1차원 배열의 2 index값들

print(b[0:2, 1:3])
print(b[:, 1:3])



