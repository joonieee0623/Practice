from p1.p2.m import name
from p1.p2.m import age
from p1.p2.m import show_name
from p1.p2.m import get_age

#print(type(m)) #<class 'module'>
print(f'(1)이름: {name}, 나이: {age}')
name = '이순신'
age +=1
print(f'(2)이름: {name}, 나이: {age}')

show_name()
result = get_age()
print(f'함수를 통해 가져온 나이: {result}')

#실행 (penv) PS C:\SOO\Python\day04> py -m use_case.muser2_1
