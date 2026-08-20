# class, object(객체), instance(클래스로 만든 데이터) 
class Human1: #빈클래스 정의 
    pass 

m1 = Human1() #객체생성
print(m1)

class Human2: #멤버(속성==property)가 1개인 클래스
    name = '길동'

m2 = Human2() #객체생성
print('m2.name:', m2.name)
print()


class Human3:
    version = '1.0' #static속성

    def __init__(self, name, age): #생성자 
        self.name = name
        self.age = age

    def m1(self): #메소드 
        print('m1()')

    def m2(self, addr): #메소드
        self.addr = addr
        print('m2() name:',self.name, ', age:', self.age, ', addr:', self.addr)

m3 = Human3('이순신', 30) #객체생성
#print(type(m3)) #Human3

# resource 이용예 
m3.m1()  #사용1
m3.m2('성남시') #사용2
print('m3.name:', m3.name) #사용3 (속성1)
print('m3.age:', m3.age) #사용4 (속성2)
print('m3.addr:', m3.addr) #사용5 (속성3)
#print('m3.version:', m3.version) #사용6(속성4)
print('Human3.version:', Human3.version) #사용6(속성4)

m3.addr = '서울시'
print('m3.addr:', m3.addr) 

m3.phone = '010-123-1234' #멤버추가
print('name:',m3.name, ', age:', m3.age, ', addr:', m3.addr, ', phone:', m3.phone)

del m3.phone #멤버삭제
# print('name:',m3.name, ', age:', m3.age, ', addr:', m3.addr, ', phone:', m3.phone) #에러

del m3

