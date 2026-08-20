
for x in 'tiger':
    print(x)

print("(실습)while문 사용 반복-------------")
# while 문으로 작성
for x in 'tiger':
    print(x)


print("for문 사용 반복-------------")
# for 문으로 작성
for i in range(2):
    for x in 'tiger':
        print(x)

print("======================")

for x in range(5):
    print(x)
print()


for x in range(0, 5, 2):
    # if x==2: break
    print(x)
else: #break로 인해 나올때는 수행X
    print('난 언제 수행?')

print('for 끝')