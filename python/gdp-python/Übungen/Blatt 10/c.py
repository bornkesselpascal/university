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
print(result)
sorted_result = sorted(result, key=lambda item: item[0])

for item, occ in  sorted_result:
    print(f'{item}: ', end='')

    sorted_occ = sorted(occ.items(), key= lambda paar: (-paar[1], paar[0].lower()))
    # Tick: wir wollen Zahlen reversed, aber das 2. Kriterium normal -> - (1. Krieterium)
    sorted_occ = sorted_occ[:5]
    
    for wort, anzahl in sorted_occ:
        print(f'{wort} ({anzahl}), ', end='')

    # ODER: JOIN verwenden :-)

    print()