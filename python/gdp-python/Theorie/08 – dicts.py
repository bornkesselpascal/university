# Dictionaries
#     - Abbildung von Schlüssel (keys) auf Werte (values)
#     - Schlüssel müssen unveränderbar (keine Listen, Sets, ...) und eindeutig sein
#     - Werte können beliebige Datentypen sein


# Erzeugung von Dictionaries, Zugriff auf Elemente
#     - mit geschweiften Klammern: {} mit schlüssel: wert
#     - Hinzuügen von Elementen mit d[key] = value
#     - Zugriff auf Elemente mit d[key] - KeyError, wenn key nicht vorhanden (VORHER PRÜFEN !!!)
#     - Löschen von Elementen mit del d[key]

dict1 = {'a': 1, 'b': 2, 'c': 3}

dict1['d'] = 4

if 'a' in dict1:
    print(dict1['a'])

del dict1['a']

print(dict1)


# Methonden keys(), values(), items()
#     - keys(): Gibt eine Liste aller Schlüssel zurück
#     - values(): Gibt eine Liste aller Werte zurück
#     - items(): Gibt eine Liste von Tupeln (key, value) zurück

dict1 = {'a': 1, 'b': 2, 'c': 3}

print(dict1.keys())    # umwandeln in Menge: set(dict1.keys()) vor der weiteren Verwendung
print(dict1.values())  # umwandeln in Liste: list(dict1.values()) vor der weiteren Verwendung
print(dict1.items())


# get-Methode
#     - d.get(key, x) gibt den Wert zu einem Schlüssel zurück, oder x, wenn der Schlüssel nicht vorhanden ist
#     - dadurch kann für nicht vorhandene Schlüssel ein Standardwert zurückgegeben werden (wie eine leere Liste, die dann mit dem Index zum Dict hinzugefügt wird)



string = 'ABC, die Katze lief im Schnee'
häufigkeiten = {}

worte = string.split()
for wort in worte:
    wert = häufigkeiten.get(wort[0].lower(), 0)
    wert += 1
    häufigkeiten[wort[0].lower()] = wert

print(häufigkeiten)

häufigkeiten.clear()
for zeichen in string:
    if zeichen not in '. !?,;':
        wert = häufigkeiten.get(zeichen.lower(), 0)
        wert += 1
        häufigkeiten[zeichen.lower()] = wert

result = list(häufigkeiten.items())
sorted_result = sorted(result, key= lambda item: item[0])

for letter, number in sorted_result:
    print(letter, ':', number, sep='', end=' ')

print()