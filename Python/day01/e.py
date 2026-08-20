# 타입캐스팅 내장함수: int(), float(), str()

a = 1
b = 2.5
c = 3j
print(type(a)) #int
print(type(b)) #float
print(type(c)) #complex
print()

#(1) int() 캐스팅 
a1 = int(a)
a2 = int(b) #실수 -> 정수 
#a3 = int(c) #복소수 -> 정수는 수학적으로 불가
print(int('3')) #문자열 -> 정수
#a3 = int('호랑이') #문자열 -> 정수 불가(숫자형태의 문자열이 아니기 때문에)
print('a2:', a2) #소수이하는 버림
print()

#(2) flast() 캐스팅
b1 = float(a)  # 1 --> 1.0
b2 = float(b)
b3 = float('3')
#b4 = float(c) #복소수 -> 실수는 수학적으로 불가
print(b1)
print(b2)
print(b3)
print()

#str() 캐스팅
c1 = str(a)
c2 = str(b)
c3 = str(c)
print(c1)
print(c2)
print(c3)