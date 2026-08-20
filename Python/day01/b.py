#변수(Variable)
a = 10
print(a)
b = '스트링'
print(b)
print("----------")

a, b = '짜장', '짬뽕'
print(a)
print(b)
print()

d = c ='탕수육'
print(c); print(d); print()

e1 = '파이썬은'
e2 = '심플해'
print(e1 + e2) #+ 결합연산자
print(e1, e2)
print()

f = 'global'
def m():
    f = 'local'
    print('f1:', f) #local

    global g
    g = 'Who am i?'

m() # m 함수 호출(실행)

print('f2:', f) #global
print('g:', g) #Who am i?