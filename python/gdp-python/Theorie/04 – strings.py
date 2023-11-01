# - Strings in Python sind unveränderlich (immutable)
# - Strings sind Sequenzen von Zeichen
#     - Zugriff auf einzelne Zeichen mit Index
#     - Verwendung der bekannten Methoden von Sequenzen (len(), min(), max(), in, ...)


# Index-Methode
#   - gibt den Index des ersten Vorkommens eines Zeichens (oder Teilsequenz!) zurück
#   - mit optionalen Parametern kann die Suche eingeschränkt werden: start, end machen die Suche nur in einem Teil des Strings

s = 'Hallo'
print(s.index('l'))

# Count-Methode
#   - gibt die Anzahl der Vorkommnisse eines Zeichens (oder Teilsequenz!) zurück

print(s.count('l'))


# Groß- und Kleinschreibung
#   - upper() und lower() geben den String in Groß- bzw. Kleinschreibung zurück
#   - capitalize() gibt den String mit großem Anfangsbuchstaben zurück
#   - title() gibt den String mit großem Anfangsbuchstaben für jedes Wort zurück
#   - swapcase() gibt den String mit vertauschten Groß- und Kleinschreibungen zurück

print(s.upper())
print(s.lower())
print(s.capitalize())
print(s.title())
print(s.swapcase())


# Testmethoden
#   - isalpha() gibt True zurück, wenn der String nur aus Buchstaben besteht
#   - isdigit() gibt True zurück, wenn der String nur aus Zahlen besteht
#   - isalnum() gibt True zurück, wenn der String nur aus Buchstaben und Zahlen besteht
#   - startswith() gibt True zurück, wenn der String mit dem angegebenen String beginnt
#   - endswith() gibt True zurück, wenn der String mit dem angegebenen String endet

l = d = 0
for zeichen in '85055 Ingolstadt':
    if zeichen.isalpha(): l+=1
    if zeichen.isdigit(): d+=1

print("Anzahl Buchstaben:", l)
print("Anzahl Zahlen:", d)
print("Anzahl Zeichen:", len('85055 Ingolstadt'))

print('85055 Ingolstadt'.startswith('8505'))
print('85055 Ingolstadt'.endswith('dt'))


# Suchen und Ersetzen
#   - find() gibt den Index des ersten Vorkommens eines Zeichens (oder Teilsequenz!) zurück
#   - rfind() gibt den Index des letzten Vorkommens eines Zeichens (oder Teilsequenz!) zurück
#   - replace() ersetzt alle Vorkommnisse eines Zeichens (oder Teilsequenz!) durch einen anderen String

print('Hallo Welt'.find('l'))
print('Hallo Welt'.rfind('l'))
print('Hallo Welt'.replace('l', 'X')) # Nutzung von replace() zum Entfernen von Zeichen (,.-;:)

for c in '.!?,:;"': text = text.replace(c, '')

# Formatstrings
#   - Formatstrings sind Strings, die Platzhalter für Variablen enthalten
#   - Platzhalter werden mit geschweiften Klammern markiert
#   - Platzhalter können mit Variablen belegt werden, indem die Methode format() aufgerufen wird

print('Hallo {}! Ich mag {} Pizza!'.format('Welt', 67//5))


# Textdateien
#   - Textdateien werden mit der Funktion open() geöffnet
#   - open() gibt ein Dateiobjekt zurück, das mit read() gelesen werden kann
#   - read() gibt den Inhalt der Datei als String zurück, der mit splitlines() in eine Liste von Zeilen umgewandelt werden kann
#   - zum Schreiben in eine Datei wird die Methode write() verwendet, der ein String übergeben wird
#   - Dateien sollten immer mit close() geschlossen werden

datei = open('datei.txt', 'r')
inhalt = datei.read()
print('Inhalt:', inhalt)


# Zuweisung
#  - eine elementweise Zuweisung ist bei Strings nicht möglich, da diese unveränderlich sind

s[k] = 'j' # Fehler!
s = s[:k] + 'j' + s[k+1:]