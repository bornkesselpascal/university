# Blatt 1, Aufgabe C

vorname  =     input('Vorname : ')
nachname =     input('Nachname: ')
alter    = int(input('Alter   : '))
print()

print(f'{vorname[0]}. {nachname} ({round(alter, -1)} - {round(alter, -1)+9})')