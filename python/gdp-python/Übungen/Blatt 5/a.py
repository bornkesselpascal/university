# Blatt 5, Aufgabe A


def ist_prim(zahl):
    if zahl <= 2: return zahl == 2

    for i in range(2, zahl):
        if(zahl % i == 0):
            return False
        
        return True


zahl = int(input('Startzahl: '))
n = int(input('n: '))
if zahl % 2 == 0: zahl += 1
while n:
    if ist_prim(zahl):
        print(format(zahl, ','))
        n -= 1
    zahl += 2 # ungerade Zahlen