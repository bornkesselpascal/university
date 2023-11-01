# Blatt Z, Aufgabe A

while True:
    n = int(input('n: '))
    if n == 0: break

    print(format('*'*(n+2), '^'+str(n+4)))

    for i in range(0, n+2):
        print('*', ' '*(n+1-i), '*', ' '*(i), '*', sep='')
    
    print(format('*'*(n+2), '^'+str(n+4)))