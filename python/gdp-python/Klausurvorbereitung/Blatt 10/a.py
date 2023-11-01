# Blatt 10, Aufgabe A

file = open('Kafka.txt', 'r')
text = file.read()
file.close()

for zeichen in '.,:;?!"':
    text = text.replace(zeichen, '')

wörter = text.split()

analyse = dict()
for wort in wörter:
    wortliste = analyse.get(wort[0].lower(), [])
    wortliste.append(wort)
    analyse[wort[0].lower()] = wortliste

sortiert = sorted(analyse.items(), key=lambda item: item[0])

for buchstabe, liste in sortiert:
    print(f'{buchstabe}:', ', '.join(liste))