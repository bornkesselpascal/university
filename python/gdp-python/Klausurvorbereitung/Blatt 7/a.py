# Blatt 7, Aufgabe A

def verdichte(liste: list[int]) -> list[int]:
    verdichtet = list()
    for elem in liste[::-1]:
        if elem != 0:
            verdichtet.insert(0, elem)
        else:
            verdichtet.append(elem)

    return verdichtet


liste1 = [0, 0, 3, 0, 0, 1, 0, 5, 0, 0]
liste2 = verdichte(liste1)
print(liste1)
print(liste2)