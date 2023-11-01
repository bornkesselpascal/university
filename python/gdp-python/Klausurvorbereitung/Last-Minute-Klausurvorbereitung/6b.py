
def highlight(string):
    i = 0
    
    while i < len(string):
        j = i + 1
        while j < len(string) and string[j].lower() == string[j-1].lower():
            j+=1

        if j-i >= 3:
            string = string[:i] + string[i:j].upper() + string[j:]

        i = j

    return string


s = 'Aaah, eine suuuuper Werkstatttreppe!!!'
print(s)
print(highlight(s))