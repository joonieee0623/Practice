def m1(): #정의
    print('m1()')

m1() #호출


def m2(): #정의
    a = '빵'
    return a

# print(m2())
b = m2() #호출
print(b)


def m3(a, b): #정의
    return a+b

c = m3(10, 20)
print(c)