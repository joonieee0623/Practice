#(미션) 1~100까지의 총합, 짝수합(even_sum), 홀수합(odd_sum)을 출력해보세요








#------------------
a = 0
sjj = 0
shol = 0
while a<100:
    a+=1
    if a%2 == 0:
        sjj+=a
    else:
       shol+=a     
    
print('짝합:',sjj, ' 홀합:', shol, ' 총합:', sjj+shol)