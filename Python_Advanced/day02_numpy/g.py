import numpy as np

a = np.array([1,2,3,4,5])
a2 = a.copy() #복사
a3 = a.view() #원본 배열(a)를 '메모리번지수' 참조 = 같은 객체 /똑같은 결과..
a[0] =10
#a3[-1] = 50 #a[4] = 50

print(a)
print(a2)
print(a3)
print()

print(a2.base) #None
print(a3.base) #a가 base가 됨
