# Eigenschaften von Sets (Mengen)
#     - Sets sind ungeordnet
#     - Sets sind veränderbar (außer frozenset)
#     - Sets enthalten keine doppelten Elemente
#     - Elemente in Sets sind unveränderbar (keine Listen, Sets, ... als Elemente)


# Erzeugung von Sets
#     - mit geschweiften Klammern: {}
#     - mit der Funktion set() (leeres Set, oder aus einem anderen Datentyp wie Tupel, String, ...)

set1 = {1, 2, 3, 4, 5,}
set2 = set()
set3 = set("Hallo")

print(set1, set2, set3, sep="\n")


# Set-Methoden
#     - add(elem): Fügt ein Element zu einem Set hinzu
#     - discard(elem): Entfernt ein Element aus einem Set
#     - clear(): Entfernt alle Elemente aus einem Set

set1 = {1, 2, 3, 4, 5}
set1.add(6)
set1.discard(3)

print(set1)


# Set-Operationen
#     - union(set): Vereinigungsmenge zweier Sets (| oder union()) (alle Elemente, die in set1 oder set2 vorkommen)
#     - intersection(set): Schnittmenge zweier Sets (& oder intersection()) (Elemente, die in beiden Sets vorkommen)
#     - difference(set): Differenzmenge zweier Sets (- oder difference()) (Elemente, die in set1, aber nicht in set2 vorkommen)

#     - in / not in: Prüfen, ob ein Element in einem Set vorkommt
#     - issubset(set): Prüfen, ob ein Set eine Teilmenge eines anderen Sets ist
#     - issuperset(set): Prüfen, ob ein Set eine Obermenge eines anderen Sets ist

#     - for elem in set: Iteration über alle Elemente eines Sets
#     - len(set) / min(set) / max(set)
#     - sorted(set): Gibt eine sortierte Liste der Elemente eines Sets zurück


set1 = {1, 2, 3, 4, 5}
set2 = {4, 5, 6, 7, 8}

print(set1.union(set2))
print(set1.intersection(set2))
print(set1.difference(set2))

print(1 in set1)
print(set1.issubset(set2))#
print({3 ,4}.issubset(set1))
print(set1.issuperset(set2))

print(sorted(set1))


# Set-Comprehensions
#     - Set-Comprehensions sind ähnlich wie List-Comprehensions, nur dass sie Mengen erzeugen
#     - Syntax: {ausdruck for var in iterable if bedingung}

set1 = {x for x in range(1, 11)}
print(set1)