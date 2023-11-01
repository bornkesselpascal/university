# Blatt 7, Aufgabe A

def verdichte(liste):
    li2 = []
    for elem in liste[::-1]:
        if elem != 0:
            li2.insert(0, elem)
        else:
            li2.append(elem)

    return li2

liste1 = [0, 0, 3, 0, 0, 1, 0, 5, 0, 0]
liste2 = verdichte(liste1)
print(liste1)
print(liste2)