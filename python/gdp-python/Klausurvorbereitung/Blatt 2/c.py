# Blatt 2, Aufgabe C

cent = int(float(input('Betrag in €: ')) * 100)

münzen = dict()

euro_2 = cent // 200
cent = cent % 200

euro_1 = cent // 100
cent = cent % 100

cent_50 = cent // 50
cent = cent % 50

cent_20 = cent // 20
cent = cent % 20

cent_10 = cent // 10
cent = cent % 10

cent_5 = cent // 5
cent = cent % 5

cent_2 = cent // 2
cent = cent % 2

cent_1 = cent

print(euro_2, euro_1, cent_50, cent_20, cent_10, cent_5, cent_2, cent_1)
