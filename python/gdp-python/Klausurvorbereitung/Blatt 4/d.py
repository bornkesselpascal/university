# Blatt 4, Aufgabe D

satz = input('String    : ')
part = input('Teilstring: ')

occurence = 0
index = 0

while satz.find(part, index) != -1:
    position = satz.find(part, index)
    index = position + len(part)
    occurence += 1

print(f'"{part}" kommt in "{satz}" {occurence} mal vor.')