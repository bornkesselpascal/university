# Blatt 4, Aufgabe A

wort = input('Wort: ')

index = 0
check = True
while index < len(wort)/2:
    if(wort[index]!=wort[-(index+1)]):
        check = False
        break

    index+=1

if check: print(wort, 'ist ein Palindrom.')
else: print(wort, 'ist kein Palindrom.')