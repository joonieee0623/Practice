print('Start!')

def m():
    print('m() 호출')

def main():
    print('main() 호출')
    m()

print("__name__ :", __name__)
if __name__ == '__main__':
    main()
    
print('End!')

