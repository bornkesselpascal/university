# Blatt 9, Aufgabe A und B

verbindungen = {
    ('VLV', 'SPC'), ('SPC', 'TFN'), ('TFN', 'GOM'), ('TFN', 'LPA'),
    ('GOM', 'LPA'), ('TFN', 'FUE'), ('LPA', 'FUE'), ('FUE', 'ACE')
}


def alle_städte(verbindungen):
    städte = set()

    for von, nach in verbindungen:
        städte.add(von)
        städte.add(nach)

    return städte


def nachbarn(stadt, verbindungen):
    nachbarn = set()

    for von, nach in verbindungen:
        if stadt == von:
            nachbarn.add(nach)
        if stadt == nach:
            nachbarn.add(von)

    return nachbarn


städte = alle_städte(verbindungen)
print(städte)

for stadt in sorted(städte):
    nachbarstädte = sorted(nachbarn(stadt, verbindungen))
    print('Flüge ab', stadt + ':', ', '.join(nachbarstädte))