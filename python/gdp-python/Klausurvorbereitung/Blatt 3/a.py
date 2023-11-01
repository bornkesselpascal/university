# Blatt 3, Aufgabe A

from math import log

n = int(input('n: '))

ln = 0
for i in range(1, n+1):
    if i%2 != 0:
        ln += 1/i
    else:
        ln -= 1/i

print("Reihe:", round(ln, 16))
print("Math :", round(log(2), 16))
