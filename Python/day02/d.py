#조건문(if)
a = 1
b = 2
if a < b:
    print(f'{a}가 {b}보다 작다')
else: 
    print(f'{a}가 {b}보다 크거나 같다')
print()

print(f'{a}가 {b}보다 작다') if a<b else print(f'{a}가 {b}보다 크거나 같다')
print()

i = 0
if i > 0:
    print('0 보다 크다')
elif i < 0:
    print('0 보다 작다')
else:
    print('0이다')

print()

c1 = -1
c2 = 0
c3 = 1
if c1 < c2 and (c2 > c3 or c1 < c3):
    print('수행')

print()

if -1<0:
    pass

print("끝")

#-------------------
name = "홍길동"

if name:
    print("True")
else:
    print("False")
