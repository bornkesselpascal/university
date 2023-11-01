# Blatt 1, Aufgabe B

eingabe = int(input('Sekunden: '))

stunden = eingabe//3600
minuten = (eingabe % 3600)//60
sekunden = (eingabe % 3600) % 60

print(format(stunden, '02'), format(minuten, '02'), format(sekunden, '02'), sep=':')