# Blatt Z, Aufgabe C

def umlaute(datei):
    anzahl_zeilen = 0
    anzahl_umlaute = 0

    for zeile in datei:
        anzahl_zeilen += 1
        anzahl_umlaute += zeile.count('ä')
        anzahl_umlaute += zeile.count('ö')
        anzahl_umlaute += zeile.count('ü')

    return anzahl_umlaute/anzahl_zeilen

datei = open('Kafka.txt', 'r')
print('Durchschnitt:', umlaute(datei), 'Umlaute/Zeile')