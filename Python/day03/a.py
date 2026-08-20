#반복문(for): Collection과 친함 
a = ['tiger', 'lion', 'rabbit','mouse', 'dog', 'snake']

''' 이것도 가능하지만, 더 좋은 방법이 있음
i = 0
while i < len(a):
    print(a[i])
    i += 1
'''

for x in a:
    # if x=='rabbit': continue
    print(x)

print("------------")
for i in range(len(a)):
    print(a[i])