# Blatt 4, Aufgabe A

def palindrom(wort) -> bool:
    if len(wort) <= 1: return True
    return wort[0] == wort[-1] and palindrom(wort[1:len(wort)-1])

while True:
    wort = input('Wort: ')
    if wort == '': break

    print(palindrom(wort))