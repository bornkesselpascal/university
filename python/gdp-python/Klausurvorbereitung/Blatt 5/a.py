# Blatt 5, Aufgabe A

def ist_prim(zahl):
    for i in range(2, zahl):
        if zahl % i == 0:
            return False
    return True


for i in range(0, 101):
    if ist_prim(i):
        print(i)