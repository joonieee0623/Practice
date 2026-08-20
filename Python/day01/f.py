# 타입캐스팅 내장함수: bool()

print(bool('점심식사')) #True
print(bool('')) #False
print()

print(bool(1)) #True
print(bool(0)) #False
print()

print(bool(['가', '나'])) #True
print(bool([])) #False
print()

#Flase로 리턴하는 예 
print(bool(False)) 
print(bool(None))
# print(bool(NULL)) # 코드내에서는 NULL은 사용하지 않음 
print(bool(0))
print(bool(''))
print(bool(""))
print(bool([])) #list
print(bool(())) #tuple
print(bool({})) #dict
print(bool(set())) #set 