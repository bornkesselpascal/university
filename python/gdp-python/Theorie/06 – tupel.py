# TUPEL sind wie STRINGS unveränderliche Sequenzen, im Gegensatz zu LISTEN

# Erzeugung von Tupeln
#    - mit der Funktion tuple()
#    - mit der Funktion zip()
#    - mit runden Klammern

# Erzeugung eines Tupels mit der Funktion tuple()
t1 = tuple("Hallo")
print(t1)

# Erzeugung eines Tupels mit der Funktion zip()
t2 = tuple(zip("Hallo", "Welt"))
print(t2)

# Erzeugung eines Tupels mit der Funktion range()
t3 = tuple(range(10))
print(t3)

# Erzeugung eines Tupels mit runden Klammern
t4 = ("Hallo", "Welt")
print(t4)


# Zugriff auf die Elemente eines Tupels
#    - mit dem Index
#    - mit dem Slice-Operator

print(t4[0])
print(t4[::-1])


# Tupel ein- und auspacken
#    - mit Zuweisung

a, b = t4
print(a)
print(b)


# Parameter *args
#    - *args ist ein Tupel, das alle übergebenen Parameter enthält die nicht mit einem Schlüsselwort versehen sind
#    - *args wird in der Funktionsdefinition mit einem Sternchen vor dem Parameter angegeben

def f(*args):
    for elem in args:
        print(elem, end=" ")

    print()

f(1, "Hallo", 5)
f(1, 2, 3, "Hallo", 5)