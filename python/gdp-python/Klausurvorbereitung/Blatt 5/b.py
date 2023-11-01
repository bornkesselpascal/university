# Blatt 5, Aufgabe B

def längste_folge(string: str) -> str:
    i = 0
    result = ''

    while i < len(string):
        j = i+1
        while j < len(string) and string[j] > string[j-1]:
            j+=1

        if j-i > len(result):
            result = string[i:j]

        i = j

    return result

print('"' + längste_folge('Weihnachten') + '"')


    