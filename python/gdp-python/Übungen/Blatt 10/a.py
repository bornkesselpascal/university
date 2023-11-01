# Blatt 10, Aufgabe A

file = open('Kafka.txt', 'r')
text = file.read()
file.close()

for c in '.!?,:;"': text = text.replace(c, '')
worte = text.split()

zerlegung = {}

for wort in worte:
    occ = zerlegung.get(wort[0].lower(), [])
    occ.append(wort)
    zerlegung[wort[0].lower()] = occ

result = list(zerlegung.items())
sorted_result = sorted(result, key=lambda item: item[0])

for item, occ in  sorted_result:
    print(item, ': ', occ, sep='')