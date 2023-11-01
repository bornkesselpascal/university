# Blatt 3, Aufgabe B

while(True):
    n = int(input('n: '))
    if n==0: break

    breite = (2*n)+3
    
    print(format('*', '^' + str(breite)))

    for i in range(0, n+1):
        print(' '*(((breite-1)//2)-1-i) + '*' + ' '*i + "*")

    for i in range(0, n+1):
        print(format('*', '^' + str(breite)))

    print(format('*'*(2*n-1), '^' + str(breite)))
