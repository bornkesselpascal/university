# Blatt 2, Aufgabe B

gewicht = float(input('Gewicht: '))
länge   = float(input('Länge  : '))

if gewicht < 100:
    print('zu leicht')

if länge < 50:
    print('zu kurz')

if gewicht >= 100 and länge >= 50:
    print('in Ordnung')