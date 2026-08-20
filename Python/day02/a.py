#문자열 핸들링 
a = '안녕 방가워 파이썬'
print(a[0])
print(a[-1])
print()

print(a[0:2])
print()

print(a[-3:])
print(a[7:])
print(a[:5] + "-")
print()

print(len(a))
print()


b = '       안녕 방가워 파이썬    '
print(len(b))
print(len(b.strip()))
print()

c = 'Good morning'
print(c.upper())
print(c.lower())
print()

d = 'Wiack and Wiue' #Wi -> Bl
print(d.replace('Wi', 'Bl'))
print()

print(d) #str불변성

e = 'Wi' not in d   # 연산자: in 또는 not in
print(e)