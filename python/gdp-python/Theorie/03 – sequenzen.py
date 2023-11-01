# Seqzenzen
#    - Listen, Tupel, Strings
#    - Listen sind veränderbar, Tupel und Strings nicht
#    - Listen und Tupel können beliebige Elemente enthalten, Strings nur Zeichen


# Zugriff auf Elemente
#    - Zugriff auf Elemente mit Index, Index beginnt bei 0
#    - Zugriff auf Elemente mit negativem Index, -1 ist das letzte Element

liste = [1, 2, 3, 4, 5]
print(liste[0])
print(liste[-1])


# Verkettung von Sequenzen
#    - Verkettung von Sequenzen mit + (gleicher Typ muss vorliegen)
#    - Vervielältigung von Sequenzen mit *

liste1 = [1, 2, 3]
liste2 = [4, 5, 6]

print(liste1 + liste2)  # Eine neue Liste wird erzeugt mit den Elementen von liste1 und liste2
print(liste1 * 3)       # Eine neue Liste wird erzeugt mit den Elementen von liste1 dreimal hintereinander


# Test auf Zugehörigkeit
#    - Test auf Zugehörigkeit mit in und not in

liste = [1, 2, 3, 4, 5]
print(3 in liste)
print(6 in liste)

print('p' in 'Python')
print('p'.upper() in 'Python')


# Länge einer Sequenz
#    - Länge einer Sequenz mit len()

liste = [1, 2, 3, 4, 5]
print(len(liste))


# Slicing
#    - Slicing mit [start:stop:step]
#    - start ist der Startindex, stop ist der Endindex (exklusiv), step ist die Schrittweite

liste = [1, 2, 3, 4, 5]
print(liste[1:3])
print(liste[1:5:2])
print(liste[::2])
print(liste[::-1])
