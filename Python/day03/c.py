li = [1,2,3,4]

#고전적인 방법 
result = []
for x in li:
    if x%2 == 0:
        r = '짝수'
    else: 
        r = '홀수'
    result.append(r)

print(result)

print()

#현대적인 방법 
result = ['짝' if x%2==0 else '홀' for x in li]
print(result)