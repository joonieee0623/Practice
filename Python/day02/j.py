# 구구단 
b = 1
while b < 9:
    b += 1

    a = 0
    while a < 9:
        a += 1
        print(f'{b} * {a} = {b*a}')
    print()


# 구구구단
c = 1
while c<9:
    c+=1

    b = 0
    while b<9:
        b+=1

        a = 0
        while a<9:
            a+=1
            print(f'{c} * {b} * {a} = {c*b*a}')

        print()
