# Blatt 6, Aufgabe B

def highlight(satz: str) -> str:
    i = 0
    result = satz

    while i < len(satz):
        j = i + 1
        while(j < len(satz) and satz[j].lower() == satz[j-1].lower()):
            j+=1
        
        if j - i >= 3:
            result = result[:i] + satz[i].upper() * (j-i) + result[j:]

        i = j

    return result

s = 'Aaah, eine suuuuper Werkstatttreppe!!!'
print(s)
print(highlight(s))