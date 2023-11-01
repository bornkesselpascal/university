# Blatt 7, Aufgabe D

file = open('Kafka.txt', 'r')
text = file.read()
file.close()

zeilen = text.split('\n')
zeichen = [z for z in text if z != ' ' and z != '\n']

worte = 0
längstes_wort = ''

for zeile in zeilen:
    worte_in_zeile = zeile.split()
    worte += len(worte_in_zeile)

    worte_sortiert = sorted(worte_in_zeile, key=len)
    if len(worte_sortiert) > 0 and len(worte_sortiert[-1]) > len(längstes_wort):
        längstes_wort = worte_sortiert[-1]


print('Zeilen :', len(zeilen))
print('Wörter :', worte)
print('Zeichen:', len(zeichen))
print('Längstes Wort:', längstes_wort)