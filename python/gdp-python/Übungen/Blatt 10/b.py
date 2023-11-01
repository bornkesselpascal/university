# Blatt 9, Aufgabe B

file = open('Kafka.txt', 'r')
text = file.read()
file.close()

for c in '.!?,:;"': text = text.replace(c, '')
worte = text.split()

zerlegung = {}

for wort in worte:
    occ = zerlegung.get(wort[0].lower(), {})
    occ_wort = occ.get(wort, 0)
    occ_wort += 1
    occ[wort] = occ_wort
    zerlegung[wort[0].lower()] = occ

result = list(zerlegung.items())
sorted_result = sorted(result, key=lambda item: item[0])

for item, occ in  sorted_result:
    print(f'{item}: ', end='')

    for wort, anzahl in occ.items():
        print(f'{wort} ({anzahl}), ', end='')

    print()