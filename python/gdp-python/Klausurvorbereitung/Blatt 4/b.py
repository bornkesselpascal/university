# Blatt 4, Aufgabe B

wort = input('Wort: ')
zwischenraum = int(input('Zwischenraum: '))

wort_liste = list(wort)
print(('_'*zwischenraum).join(wort_liste))