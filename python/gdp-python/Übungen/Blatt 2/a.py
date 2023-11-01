# Blatt 2, Aufgabe A

num = int(input('Geben Sie eine Zahl ein: '))
ans = input('Ist die Zahl gerade (g) oder ungerade (u)? ')

if (num%2 == 0) and ans == 'g':
    print("Die Antwort ist richtig!")
elif (num%2 != 0) and ans == 'u':
    print("Die Antwort ist richtig!")
else:
    print("Die Antwort ist falsch!")