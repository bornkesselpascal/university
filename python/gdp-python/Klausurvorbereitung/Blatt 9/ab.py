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

städte = alle_städte(verbindungen)
print(städte)


def nachbarn(stadt, verbindungen):
    nachbarn = set()

    for von, nach in verbindungen:
        if von == stadt: nachbarn.add(nach)
        if nach == stadt: nachbarn.add(von)

    return nachbarn

for stadt in sorted(städte):
    nachbarstädte = sorted(nachbarn(stadt, verbindungen))
    print('Flüge ab', stadt + ':', ', '.join(nachbarstädte))