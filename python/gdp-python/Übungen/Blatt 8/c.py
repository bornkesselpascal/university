# Blatt 8, Aufgabe C

def von_nach(städte):
    verbindungen = list()

    for i in range(0, len(städte)):
        for j in range(0, len(städte)):
            if städte[i] != städte[j]:
                verbindungen.append((städte[i], städte[j]))

    return verbindungen


städte = ['München', 'Berlin', 'Hamburg']
verbindungen = von_nach(städte)
for von, nach in verbindungen:
    print(von, '-', nach)