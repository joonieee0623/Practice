import matplotlib.pyplot as plt
from numpy import random as r

#x = r.normal(size=100) #100개의 랜덤'배열array' (기준값:0) 1차원(Vector)
#x = r.normal(size=(2,3)) #2행 3열 랜덤배열 (기준값:0) 2차원(Matrics)
#x = r.normal(size=(2,2,2)) #2행 2열 랜덤배열dl 2개 (기준값:0) n차원(Tensor)
#print(x)

x = r.normal(100, 2, 500) #(기준값, 표준편차, 생성갯수)
print(x)

plt.hist(x)

plt.show()

