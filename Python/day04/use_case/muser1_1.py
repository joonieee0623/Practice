from p1.p2 import m

#print(type(m)) #<class 'module'>
print(f'(1)이름: {m.name}, 나이: {m.age}')
m.name = '이순신'
m.age +=1
print(f'(2)이름: {m.name}, 나이: {m.age}')

m.show_name()
result = m.get_age()
print(f'함수를 통해 가져온 나이: {result}')

#실행 (penv) PS C:\SOO\Python\day04> py -m use_case.muser1_1
