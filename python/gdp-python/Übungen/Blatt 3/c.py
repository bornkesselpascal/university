# Blatt 3, Aufgabe C

kredit = float(input('Kredit    : '))
zins   = float(input('Zinssatz  : '))
rate   = float(input('Monatsrate: '))

monat = 0

while kredit > 0:
    monat += 1
    zinsen = kredit * zins/(100*12)
    monatsrate = min(rate, kredit+zinsen)
    tilgung = monatsrate - zinsen
    kredit = kredit - tilgung

    print(format(monat, "3"), end=' ')
    print(format(round(monatsrate, 2), "6.2f"), end=' ')
    print(format(round(zinsen, 2), "6.2f"), end=' ')
    print(format(round(tilgung, 2), "8.2f"), end=' ')
    print(format(round(kredit, 2), "10.2f"))