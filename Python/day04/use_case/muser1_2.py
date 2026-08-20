from p1.p2 import m as nn

#print(type(m)) #<class 'module'>
print(f'(1)이름: {nn.name}, 나이: {nn.age}')
nn.name = '이순신'
nn.age +=1
print(f'(2)이름: {nn.name}, 나이: {nn.age}')

nn.show_name()
result = nn.get_age()
print(f'함수를 통해 가져온 나이: {result}')

#실행 (penv) PS C:\SOO\Python\day04> py -m use_case.muser1_2
