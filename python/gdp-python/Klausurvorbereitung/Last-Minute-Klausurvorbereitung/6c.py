def wortumkehr(wort):
    i = 0
    while i < len(wort):
        if not wort[i].isalpha():
            i+=1
            continue

        j = i+1
        while j < len(wort) and wort[j].isalpha():
            j+=1

        wort = wort[:i] + wort[i:j][::-1] + wort[j:]

        i = j

    return wort


s = 'Ein (kleines!) Beispiel...'
print(s)
print(wortumkehr(s))