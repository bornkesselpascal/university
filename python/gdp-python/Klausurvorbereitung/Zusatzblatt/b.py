# Blatt Z, Aufgabe B

def hervorheben(string):
    while string.find('(') != -1:
        open_index = string.find('(')
        close_index = string.find(')')
        string = string[:open_index] + '_'.join(string[open_index+1:close_index]) + string[close_index+1:]

    return string


print(hervorheben('Ein (kleines) Beispiel, (ohne) Klammern!'))