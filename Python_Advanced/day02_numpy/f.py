import numpy as np

a= np.array([1,2,3,4,5])
print(type(a)) #numpy.ndarray
print(a.dtype) #int64
print()

b = np.array(["tiger", "lion", "rabbit"])
print(type(b)) #numpy.ndarray
print(b.dtype) # <U6 (U : 유니코드 + 6: 최대문자갯수)
print()

c = np.array([1,2,3,4,5], dtype='S')
print(c)
print(c.dtype) # S1(S: 문자열 , 1: 최대문자갯수)
print()

d = np.array([1,2,3,4,5], dtype='i8') # i: int, 8: 원소당 8byte , 1byte == 8bit
print(d)
print(d.dtype) #int64 (8*8)
print()

e = np.array([1.3,2.5,3.8])
print(e)
print(e.dtype) #float64 무한대../ 소수 오차
print()

#e2 = e.astype('i') #데이터타입 컨버팅 메소드
e2 = e.astype('int') # 위와 같음
print(e2)
print(e2.dtype) #int64
print()

f = np.array([-2, 0, 1, 7])
f2 = f.astype(bool)
print(f2)
print(f2.dtype)

