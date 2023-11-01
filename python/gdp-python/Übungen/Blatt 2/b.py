# Blatt 2, Aufgabe B

g = float(input('Gewicht: '))
l = float(input('Länge  : '))

if g >= 100 and l >= 50:
    print('in Ordnung')
else:
    if g < 100: print('zu leicht')
    if l < 50: print('zu kurz')