# Blatt 7, Aufgabe B

def drucke_summen(matrix):

    for zeile in matrix:
        for zahl in zeile:
            print(format(zahl, '2'), end=' ')
        print('|', format(sum(zeile), '2'))

    print('-'*12, '|', '-'*3, sep='')

    gesamtsumme = 0
    for spalte in range(0, len(matrix[0])):
        summe = 0
        for zeile in matrix:
            summe += zeile[spalte]
        print(format(summe, '2'), end=' ')
        gesamtsumme += summe

    print('|', format(gesamtsumme, '2'))
    


drucke_summen([
    [4, 5, 2, 7],
    [3, 6, 1, 9],
    [9, 8, 2, 6]
])