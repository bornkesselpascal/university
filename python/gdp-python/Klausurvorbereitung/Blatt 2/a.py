# Blatt 2, Aufgabe A

zahl  = int(input('Geben Sie eine Zahl ein: '))
frage = input('Ist die Zahl gerade (g) oder ungerade (u)? ')

if zahl%2 == 0 and frage == 'g':
    print('Die Antwort ist richtig!')
elif zahl%2 != 0 and frage == 'u':
    print('Die Antwort ist richtig!')
else:
    print('Die Antwort ist falsch!')