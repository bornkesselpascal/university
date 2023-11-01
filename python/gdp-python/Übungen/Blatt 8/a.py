# Blatt 8, Aufgabe A

verzeichnis = []

while True:
    name = input('Name: ')
    if name == '':
        break
    tel  = int(input('Tel.: '))
    verzeichnis.append((name,tel))

if len(verzeichnis) > 0:
    sortiert = sorted(verzeichnis, key = lambda entry: entry[0])
    
    for name, tel in sortiert:
        print(name, tel)