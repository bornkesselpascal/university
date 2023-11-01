# Blatt 7, Aufgabe C

def dreifachkonsonanten(satz):
    results = []

    i = 0
    while i < len(satz):
        j = i
        while j < (len(satz)-1) and satz[j]==satz[j+1]:
            j+=1
        
        if j-i >= 2:
            if satz[j-1] not in 'aeiou':
                results.append(satz[j])

        i=j+1
    
    return sorted(results)

satz = "Flussschifffahrt auf den Hawaiiinseln"
print(satz)
print("Dreifachkonsonanten:", dreifachkonsonanten(satz))