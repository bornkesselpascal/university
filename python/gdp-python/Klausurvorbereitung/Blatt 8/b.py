# Blatt 8, Aufgabe B

def ordne_nach_alter(personen: list[tuple[str, int]]) -> tuple[list[tuple[str, int]]]:
    vj = list()
    mj = list()

    for entry in personen:
        if entry[1] >= 18:
            vj.append(entry)
        else:
            mj.append(entry)

    vj.sort(key= lambda entry: entry[1])
    mj.sort(key= lambda entry: entry[1])
    return (vj, mj)


personen = [('Tim', 20), ('Tom', 17), ('Julia', 9), ('Clara', 19)]
volljährig, minderjährig = ordne_nach_alter(personen)
print('Minderjährig:', minderjährig)
print('Volljährig :', volljährig)