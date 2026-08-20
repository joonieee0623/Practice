#(1) Text: str
a = '문자열'
print(type(a)) #<class 'str'>
print()

#(2)  Numeric: int, float, complex( 예: 1+1j )
b = 1
print(type(b)) #<class 'int'>
print()  

c = 0.12
print(type(c)) #<class 'float'>
print()

#(3) Sequence: list, tuple, range
d = ['가', '나', '다']
print(type(d)) #<class 'list'>
print()

e = ('가', '나', '다') #unchangeable
print(type(e)) #<class 'tuple'>
print() 

f1 = range(4) #0이상 n미만
for i in f1:
    print(i) #0,1,2,3
print()

f2 = range(2, 4) #2이상 4미만
for i in f2:
    print(i) #2,3
print()

#(4) Set: set, frozenset 
g1 = {'가', '나', '다', '가'}
print(type(g1)) #<class 'set'>
print()
for s in g1:
    print(s) 

g1.add('라')
print(g1)
print()

g2 = frozenset(g1) #unchangeable
print(type(g2)) #<class 'frozenset'>
print()

#(5) Mapping: dict
h = {'name' : '길동', 'age':22, 'addr':'성남시'}
print(type(h)) #<class 'dict'>
print()


#z = {}
#z = set()
#print(type(z)) #<class 'dict'> <class 'set'>

#(6) Boolean: bool - True, False
i = False
print(type(i)) #<class 'bool'
print()

import numpy as np
arr = np.array([2.2, 4.4])
print(type(arr)) #<class 'numpy.ndarray'>

'''
< 배열 차원 >
0차원: 스칼라(Scalar)
1차원: 벡터(Vector)
2차원: 행렬(Matrix)
3차원이상: 텐서(Tensor)
'''