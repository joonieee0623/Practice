#문자열 출력 

#(0) + 이용
name = '길동'
age = 22
a = '나는 이름이 ' + name + '이고, 나이가 ' + str(age) + '살이다'
print(a)
print()

#(1) format()로 출력 
b = '나는 이름이 {}이고, 나이가 {}살이다'
print(b.format(name, age))
print()

c = '나는 이름이 {1}이고, 나이가 {2}살이고, {0}에 산다'
print(c.format('성남', name, age))
print()

d = '나는 급여를 ${:.2f}를 받고 싶어'
print(d.format(456.128456789)) #소수점 3째자리에서 반올림해서 2째자리 소수를 만듬

e = '나는 {com}의 {car}을 갖고 싶어'
print(e.format(car='사이버트럭', com='테슬라'))

f = '그가 "뉘시요" 라고 \n물었다'
print(f)
# Escape Characters => \", \', \\, \n, \r, \t, \b
print()

name = "홍길동"
age = 27
#(2) f 형식 출력 
g = f'나는 이름이 {name}이고, 나이가 {age}살이다'
print(g)