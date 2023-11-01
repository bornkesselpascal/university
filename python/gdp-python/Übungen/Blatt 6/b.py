# Blatt 6, Aufgabe A

def highlight(str):
    i = 0
    new = ''

    while i < len(str):
        print('i=', i)
        j = i+1
        while j < (len(str)) and str[j].upper() == str[j-1].upper():
            print('j=', j)
            j+=1
        
        for k in range(i, j):
            if(j-i >= 3):
                new = new + str[k].upper()
            else:
                new = new + str[k]

        i = j

    return new

s = 'Aaah, eine suuuuper Werkstatttreppe!!!'
print(s)
print(highlight(s))