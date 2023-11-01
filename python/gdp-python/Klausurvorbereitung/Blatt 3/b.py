# Blatt 3, Aufgabe 2

while True:
    n = int(input('n: '))
    if n == 0:
        break

    # Spitze
    print(' '*(n+1), '*', sep='')

    # Dreieck
    for i in range(0, n+1):
        print(' '*(n-i), '*', ' '*i, '*', sep='')

    # Steg
    for i in range(0, n+1):
        print(' '*(n+1), '*', sep='')

    print(' ' * 2, '*'*(2*n-1), sep='')