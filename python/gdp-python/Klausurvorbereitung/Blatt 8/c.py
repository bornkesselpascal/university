# Blatt 8, Aufgabe C

def von_nach(städte):
    verbindungen = list()

    for stadt1 in städte:
        for stadt2 in städte:
            if stadt1 != stadt2:
                verbindungen.append((stadt1, stadt2))
                
    return verbindungen


städte = ['München', 'Berlin', 'Hamburg']
verbindungen = von_nach(städte)

for von, nach in verbindungen:
    print(von, '-', nach)