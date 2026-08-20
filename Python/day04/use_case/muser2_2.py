from p1.p2.m import name as n
from p1.p2.m import age as a
from p1.p2.m import show_name as sn
from p1.p2.m import get_age as ga

#print(type(m)) #<class 'module'>
print(f'(1)이름: {n}, 나이: {a}')
n = '이순신'
a +=1
print(f'(2)이름: {n}, 나이: {a}')

sn()
result = ga()
print(f'함수를 통해 가져온 나이: {result}')

#실행 (penv) PS C:\SOO\Python\day04> py -m use_case.muser2_2
