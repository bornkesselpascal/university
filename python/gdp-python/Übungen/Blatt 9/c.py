# Blatt 9, Aufgabe C

fußballer = {'Andi', 'Paul', 'Tim', 'Tom'}
handballer = {'Otto', 'Andi', 'Tim', 'Uli'}
volleyballer = {'Andrea', 'Clara', 'Julia', 'Tim', 'Tom', 'Andi'}
basketballer = {'Otto', 'Tim', 'Hans', 'Sven', 'Andi', 'Paul'}

verein = [fußballer, handballer, volleyballer, basketballer]


def top_sportler(verein):
    top = verein[0]

    for sportarten in verein:
        top = top.intersection(sportarten)

    return top

def einzel_sportler(verein):
    einzel = set()

    for sport in verein:
        einzel = einzel.symmetric_difference(sport)

    return einzel

def doppel_sportler(verein: list[set[str]]) -> set[str]:
    sportler = {}

    for sport in verein:
        for person in sport:
            anz = sportler.get(person, 0)
            sportler[person] = (anz + 1)

    result = set()
    for person, anz in sportler.items():
        if anz == 2: result.add(person)

    return result


print(top_sportler(verein))
print(einzel_sportler(verein))
print(doppel_sportler(verein))