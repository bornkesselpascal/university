# Blatt 7, Aufgabe D

file = open('Kafka.txt', 'r')
text = file.read()
file.close()

zeilen = text.count('\n') + 1

wortliste = text.split()
wörter = len(wortliste)
längstes_wort = max(wortliste, key=len)

text = text.replace('\n', '')
text = text.replace(' ', '')
zeichen = len(text)

print('Dateiname: ', file.name)
print('Zeilen :', zeilen)
print('Wörter :', wörter)
print('Zeichen:', zeichen)
print('Längstes Wort:', längstes_wort)