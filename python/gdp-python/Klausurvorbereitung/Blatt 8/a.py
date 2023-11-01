# Blatt 8, Aufgabe A

verzeichnis = list()

while True:
    name = input('Name: ')
    if name == '': break
    nummer = int(input('Nummer: '))

    verzeichnis.append((name, nummer))

verzeichnis = sorted(verzeichnis, key = lambda entry: entry[0])
for name, nummer in verzeichnis:
    print(name, nummer)