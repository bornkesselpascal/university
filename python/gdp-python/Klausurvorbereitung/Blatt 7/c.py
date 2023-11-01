# Blatt 7, Aufgabe C

def dreifachkonsonanten(satz):
    ergebnisse = list()

    i = 0
    while i < len(satz):
        j = i + 1
        while j < len(satz) and satz[j] == satz[j-1]:
            j+=1

        if j-i >= 3:
            if(satz[i] not in 'aeiou'):
                ergebnisse.append(satz[i])

        i = j

    return ergebnisse

satz = "Flussschifffahrt auf den Hawaiiinseln"
print(satz)
print("Dreifachkonsonanten:", dreifachkonsonanten(satz))