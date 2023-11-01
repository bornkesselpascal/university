# Vergleiche
#   - Python hat die bekannten Vergleichsoperatoren ==, !=, <, >, <=, >=
#   - auch Strings können verglichen werden anhand der lexikographischen Ordnung (nach ASCII)
#   - Mehrfachvergleiche sind möglich, z.B. 0 < x < 10 (entspricht 0 < x and x < 10)

# Logische Operatoren
#   - and, or, not

# if-else-Verzweigung
#   - if-else-Verzweigung mit if, elif, else

ampelfarbe = input("Ampelfarbe: ")
if(ampelfarbe == 'rot'):
    print("Stehen bleiben!")
elif(ampelfarbe == 'gelb'):
    print("Gleich wird es rot!")
elif(ampelfarbe == 'grün'):
    print("Weiterfahren!")
else:
    print("Fehlerhafte Eingabe!")

status = 'FAHREN' if ampelfarbe == 'grün' else 'HALTEN'
print(status)


# Schleifen
#   - while-Schleife mit break
#   - for-Schleife
#   - range()

while True:
    eingabe = input("Eingabe: ")
    if(eingabe == 'ende'):
        break
    print(eingabe)

for i in range(1, 11):
    print(i, end=' ')

print()

# Die for-Schleife kann auch mit Sequentieschleifen verwendet werden
#   - Sequenz: Liste, Tupel, String, Dictionary, Set
#   - for-Schleife iteriert über die Elemente der Sequenz

liste = [1, 2, 3, 4, 5]
for element in liste:
    print(element, end=' ')

print()

for zeichen in 'Hallo':
    print(zeichen, end=' ')



# Lokale Funktionen
#   - Funktionen können in Funktionen definiert werden
#   - lokale Funktionen können nur innerhalb der umgebenden Funktion aufgerufen werden
#   - lokale Funktionen können auf lokale Variablen der umgebenden Funktion zugreifen

def f():
    def g():
        print("Hallo")
    g()

f()