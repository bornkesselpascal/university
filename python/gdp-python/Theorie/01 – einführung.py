# Operatoren, print() und format()
#   - Auspobieren der Operatoren
#   - print() mit Angabe von sep und end
#   - format() mit verschiedenen Optionen
#        - '15' oder '>15' zur Angabe der Breite (rechtsbündig)
#        - '<15' zur Angabe der Breite (linksbündig)
#        - '^15' zur Angabe der Breite (zentriert)
#        - '15.2f' zur Angabe Breite und Nachkommastellen
#        - '02' zur Angabe der Breite mit führenden Nullen statt Leerzeichen

print("Negation:", -23, sep=" ", end="\t")
print("Addition:", 23 + 7, sep=" ", end="\t")
print("Subtraktion:", 23 - 7, sep=" ", end="\n")
print("Multiplikation:", 23 * 7, sep=" ", end="\t")
print("Potenzieren:", 23 ** 7, sep=" ", end="\n")

print("Division:", format(23 / 7, '12.4f'), sep=" ", end="\n")
print("Floored Division:", format(23 // 7, '3.4f'), sep=" ", end="\n")
print("Modulo:", format(23 % 7, '<12.4f'), sep=" ", end="\n")


# Baum mit Angabe der Höhe
#   - Eingabe der Höhe mit input()
#   - Umwandlung des Strings (von input()) in einen Integer mit int()
#   - Funktion str() zum Umwandeln von Zahlen in Strings (Verkettung nur mit gleichen Typ)

höhe_str = '5' # input("Höhe des Baumes: ")
höhe = int(höhe_str)

print_str = "Es wird ein Baum mit Höhe " + str(höhe) + " erstellt."
print(print_str)

for i in range(1, höhe+1):
    print(format('*' * (2*i - 1), '^' + str(2*höhe - 1)))

for i in range(1, höhe+1):
    print(' ' * (höhe-i), end='')
    print('*' * (2*i - 1), end='\n')


# Runden von Zahlen
print(round(345.649))
print(round(345.649, 1))
print(round(345.649, -2))


# Mehrfachzuweisungen
x = 100
y = 200
print("x =", x, "y =", y)

x, y = y, x
print("x =", x, "y =", y)