# Blatt 4, Aufgabe B

wort = input('Wort: ')
gap  = int(input('Zwischenraum: '))

result = ''

for zeichen in wort:
    result = result + zeichen + "_"*gap

print(result[:-gap])