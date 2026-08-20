#2단 
for a in range(1,10):
    print(f'2 * {a} = {2*a}')

print("-------------")

#구구단
for b in range(2,10):
    for a in range(1,10):
        print(f'{b} * {a} = {b*a}')

    print()

print("=========================")
''' 
2 * 1 * 1 = 2
..
2 * 1 * 9 = 18
..
2 * 2 * 1 = 4
..
2 * 2 * 9 = 36
..
9 * 9 * 9 = 729
'''
#구구구단
for c in range(2,10):
    for b in range(1,10):
        for a in range(1,10):
            print(f'{c} * {b} * {a} = {c*b*a}')