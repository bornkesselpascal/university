# Blatt 5, Aufgabe D

import math

def sinus(x: float,k: int) -> float:
    def fakultät(i):
        if(i == 0): 
            return 1
        return i * fakultät(i-1)

    res = 0
    for i in range(0, k):
        current = x**(2*i+1) / fakultät(2*i+1)

        if(i % 2): res = res + current
        else: res = res - current
    
    return res
            


x = float(input('x: '))
k = int(input('k: '))
print(sinus(x,k))
print(math.sin(x))