fußball = {'Andi', 'Paul', 'Tim', 'Tom'}
handball = {'Otto', 'Andi', 'Tim', 'Uli'}
volleyball = {'Andrea', 'Clara', 'Julia', 'Tim', 'Tom', 'Andi'}
basketball = {'Otto', 'Tim', 'Hans', 'Sven', 'Andi', 'Paul'}

sportarten = [fußball, handball, volleyball, basketball]


def top_sportler(sportarten):
    top = sportarten[0]

    for sportart in sportarten:
        top = top.intersection(sportart)

    return top

def einzel_sportler(sportarten):
    top = set()

    for sportart in sportarten:
        top = top.symmetric_difference(sportart)

    return top

def doppel_sportler(sportarten):
    doppel = set()

    for sportart in sportarten:
        for sportler in sportart:
            count = 0
            for s in sportarten:
                if sportler in s:
                    count += 1

            if count == 2:
                doppel.add(sportler)

    return doppel


print('Top-Sportler :', ', '.join(sorted(top_sportler (sportarten))))
print('Einzel-Sportler:', ', '.join(sorted(einzel_sportler(sportarten))))
print('Doppel-Sportler:', ', '.join(sorted(doppel_sportler(sportarten))))