# Blatt 5, Aufgabe D

import math

def sinus(x, k):

    def fakultät(zahl):
        if zahl == 0: return 1
        return zahl * fakultät(zahl-1)

    result = 0
    for i in range(0, k):
        term = x**(2*i+1) / fakultät(2*i+1)

        if i % 2 == 0: result += term
        else: result -= term

    return result

x = float(input('x: '))
k = int(input('k: '))

print(sinus(x,k))
print(math.sin(x))