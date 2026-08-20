#연산자(Operator): 데이터를 연산하게하는 기호

#(1) Arithmetic ( +, -, *, /, %, //, ** )
a = 1/2
print(a)
print('a: ' + str(a))
print('a:', a) #float
print('int(a):', int(a)) #(DownCasting) float -> int
print()

b  = 1//2
print('b:', b)
print()

c = 2**3 
print('c:', c)
print()

#(2) Logical ( and, or, not ) 
i = 1
j = 0
d1 = True and i>j
print(d1)
d2 = True or i<j
print(d2)
d3 = not i<j
print(d3)
print()

#(3) Identity ( is, is not )
e = '김치'
f = 10
g = e is not f
print('g:', g)
print()

#(4) Membership ( in, not in )
li = ['a', 'b', 'c']
h = 'b' not in li
print('h:', h)
print()

#(5) Comparison ( ==, !=, >, >=, <, <= )
print(1>=1)
print()

#(6) Assignment ( =, +=, -=, *=, /=, %=, //=, **= )
i = 10
# i = i + 1
i += 1
print(i)
print()

# 고전방식  
age = 18
r = ''
if age >= 19:
    r = '성인'
else:
    r = '미성년자'
print(r)
print()

# 현대방식(Ternary) (참고: 참값 if 조건식 else 거짓값)
r = '성인' if age>=19 else '미성년자'
print(r)
