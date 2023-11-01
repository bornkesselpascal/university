# Blatt 10, Aufgabe B

file = open('Kafka.txt', 'r')
text = file.read()
file.close()

for zeichen in '.,:;?!"':
    text = text.replace(zeichen, '')

wörter = text.split()

analyse = dict()
for wort in wörter:
    wortliste = analyse.get(wort[0].lower(), {})
    anz = wortliste.get(wort, 0)
    wortliste[wort] = (anz+1)
    analyse[wort[0].lower()] = wortliste

sortiert = sorted(analyse.items(), key=lambda item: item[0])

for buchstabe, wortdict in sortiert:
    output = list((f'{wort} ({anz})') for wort, anz in wortdict.items())
    print(f'{buchstabe}:', ', '.join(output))