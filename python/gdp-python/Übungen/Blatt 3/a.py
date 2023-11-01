# Blatt 3, Aufgabe A

import math

n = int(input('n: '))
ln2 = 1

for i in range(2, n+1):
    if i%2 == 0:
        ln2-=(1/i)
    else:
        ln2+=(1/i)

print(f'Lösung mit Reihenentwicklung: {round(ln2, 16)}')
print(f'Lösung zum Vergleich        : {math.log(2)}')

