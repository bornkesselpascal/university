# Blatt 6, Aufgabe C

def wortumkehr(satz: str) -> str:
    i = 0
    result = ''

    while i < len(satz):
        if not satz[i].isalpha():
            result = result + satz[i]
            i += 1
            continue

        j = i + 1
        while j < len(satz) and satz[i:j].isalpha():
            j+=1

        result = result[:i] + satz[i:j-1][::-1]

        i = j-1

    return result


s = 'Ein (kleines!) Beispiel...'
print(s)
print(wortumkehr(s))