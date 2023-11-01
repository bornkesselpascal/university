# Blatt 8, Aufgabe B

def ordne_nach_alter(liste):
    vj = []
    mj = []

    for person in liste:
        if person[1] > 18:
            vj.append(person)
        else:
            mj.append(person)

    nach_alter = lambda person:person[1]
    sortiert_vj = sorted(vj, key= nach_alter)
    sortiert_mj = sorted(mj, key= nach_alter)

    return sortiert_vj, sortiert_mj

personen = [('Tim', 20), ('Tom', 17), ('Julia', 9), ('Clara', 19)]
volljährig, minderjährig = ordne_nach_alter(personen)
print('Minderjährig:', minderjährig)
print('Volljährig  :', volljährig)