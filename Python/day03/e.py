#함수(function)
def m1():
    print('이것이 펑션')
    
m1()
print()

def m2(name, age):
    print(f'이름: {name} 나이: {age}')

m2('홍길동', 27)
m2('김유신', 33)
print()

def m3(*ar):
    print(type(ar)) #tuple
    print(ar)
    for x in ar:
        print(x)

m3('짜장', '짬뽕')
print()

m3('짜장', '짬뽕', 100, 200)
print()

def m4(**pa):
    print(type(pa)) #dict
    print(pa)
    print(pa.items())
    for k, v in pa.items():  # ('name', '길동')
        print(k, v)

m4(name='길동', age=20, addr='성남')
print()

def m5(a, b, c):
    print(f'a:{a}, b:{b}, c:{c}')

m5(c='가', b='나', a='다')
print()

def m6(param='바보(기본값)'):
    print(param)

m6('천재')
m6()
print()

def m7(li):
    for x in li:
        print(x)

li = ['a', 'b', 'c']
m7(li)
print()

def m8(a, b):
    return a+b

r = m8(10,20)
print('r:',r)
print()

def m9():
   pass 

def m10(): #외부함수
    print('m10()')
    
    def m11(): #내부함수 
        print('m11()')

    m11()

m10()
print()

def m12():
    global a
    a = 1
    print('a(1):', a)

m12()
print('a(2):', a)
print()

def m13(): #외부함수 
    global b
    b = 2
    print('m13()')

    def m14(): #내부함수 
        global c
        c = 3
        print('m14()')

    m14()

m13()
print('b:', b) #가능 
print('c:', c) #가능
