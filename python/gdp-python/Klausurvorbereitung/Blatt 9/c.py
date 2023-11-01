fußballer = {'Andi', 'Paul', 'Tim', 'Tom'}
handballer = {'Otto', 'Andi', 'Tim', 'Uli'}
volleyballer = {'Andrea', 'Clara', 'Julia', 'Tim', 'Tom', 'Andi'}
basketballer = {'Otto', 'Tim', 'Hans', 'Sven', 'Andi', 'Paul'}

verein = [fußballer, handballer, volleyballer, basketballer]


def top_sportler(verein):
    top = verein[0]

    for sportart in verein:
        top = top.intersection(sportart)

    return top


print(top_sportler(verein))