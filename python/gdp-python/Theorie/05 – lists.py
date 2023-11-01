# Erzeugung von Listen
#   - mit eckigen Klammern: []
#   - mit der Funktion list() (leere Liste, oder aus einem anderen Datentyp wie Tupel, String, ...)
#   - mit der Funktion range() (Zahlenfolgen)
#   - durch Verkettung oder Wiederholung von Listen

liste1 = [1, 2, 3, 4, 5]
liste2 = list()
liste3 = list("Hallo")
liste4 = list(range(1, 6))
liste5 = [1, 2, 3] + [4, 5, 6]
liste6 = [1, 2, 3] * 3

print(liste1, liste2, liste3, liste4, liste5, liste6, sep="\n")


# Listenelemente ändern und löschen
#   - mit eckigen Klammern: liste[index] = wert
#   - mit der Funktion del: Entfernen eines Elements aus einer Liste an einer bestimmten Position

print(liste1)
liste1[0] = 10
del liste1[0:3] # Entfernt die Elemente an den Positionen 0, 1 und 2
print(liste1)


# Strings in Teile zerlegen und Verbinden
#   - mit der Funktion split(): Trennung anhand eines Trennzeichens
#   - mit der Funktion join(): Verbinden von Strings mit einem Trennzeichen

satz = "Das ist ein Satz"
worte = satz.split()
print(worte)

satz = "Das ist;ein;Satz"
worte = satz.split(";")
print(worte)

satz = "- ".join(worte)
print(satz)


# min, max, sum, len
#   - min(): Gibt das kleinste Element einer Liste zurück
#   - max(): Gibt das größte Element einer Liste zurück
#   - sum(): Gibt die Summe aller Elemente einer Liste zurück
#   - len(): Gibt die Anzahl der Elemente einer Liste zurück

liste = [1, 2, 3, 4, 5]
print(min(liste), max(liste), sum(liste), len(liste))


# list-Methoden
#   - append(elem): Fügt ein Element am Ende einer Liste hinzu
#   - insert(pos, elem): Fügt ein Element an einer bestimmten Position in eine Liste ein
#   - remove(elem): Entfernt ein Element aus einer Liste
#   - reverse(): Dreht die Reihenfolge der Elemente einer Liste um
#   - copy(): Erzeugt eine Kopie einer Liste (ACHTUNG: Nur oberflächlich, keine deep copy!)

liste = [1, 2, 3, 4, 5]
liste.append(6)
print(liste)

liste.insert(0, 0)
print(liste)

liste.remove(0)
print(liste)

liste.reverse()
print(liste)


# Sortieren von Listen mit sorted()
#   - sorted(liste): Gibt eine sortierte Kopie einer Liste zurück
#   - sorted(liste, reverse=True): Gibt eine sortierte Kopie einer Liste in umgekehrter Reihenfolge zurück
#   - sorted(liste, key=len): Gibt eine sortierte Kopie einer Liste zurück, sortiert nach der Länge der Elemente
#       -   key: Funktion, die auf jedes Element angewendet wird, um den Wert zu erhalten, nach dem sortiert werden soll
#       -   es handelt sich um eine Callback-Funktion, die als Parameter übergeben wird
#       -   auch mehere Parameter möglich: sorted(liste, key=func1, key=func2, ...) oder sorted(liste, key=lambda x: [x[0], x[1]])

def endbuchstabe(str):
    return str[-1]

namen = ["Hans", "Peter", "Klauz", "Walter", "Hansi", 'Marc']
sotierte_namen = sorted(namen, key=endbuchstabe)
print(sotierte_namen)

# Durch die Verwendung von Lamdba-Ausdrücken kann die Funktion endbuchstabe() eingespart werden.
#   - lambda: anonyme Funktion, die als Parameter übergeben wird
#   - Syntax: lambda parameter: ausdruck

sotierte_namen_lambda = sorted(namen, key= lambda str: str[-1])
print(sotierte_namen_lambda)


# List Comprehensions
#   - List Comprehensions sind eine kompakte Schreibweise für die Erzeugung von Listen
#   - Syntax: [ausdruck for element in liste]
#   - Syntax: [ausdruck for element in liste if bedingung]

liste = [1, 2, 3, 4, 5]
liste2 = [elem * 2 for elem in liste]
print(liste2)

liste = [1, 2, 3, 4, 5]
liste2 = [elem * 2 for elem in liste if elem % 2 == 0]
print(liste2)

liste = "Anna, Peter, Klaus, Hans, Walter".split(", ")
liste2 = [elem for elem in liste if elem[-1] == "s"]
print(liste2)