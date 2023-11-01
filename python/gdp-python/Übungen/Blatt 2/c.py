# Blatt 2, Aufgabe C

money = float(input('Betrag in €: '))

print()

coin_2e = money//2
if(coin_2e > 0):
    print(int(coin_2e), 'x  2 €')
    money = money - 2*coin_2e

coin_1e = money//1
if(coin_1e > 0):
    print(int(coin_1e), 'x  1 €')
    money = money - 1*coin_1e

coin_50 = money//0.5
if(coin_50 > 0):
    print(int(coin_50), 'x 50 Cent')
    money = money - 0.5*coin_50

coin_20 = money//0.2
if(coin_20 > 0):
    print(int(coin_20), 'x 20 Cent')
    money = money - 0.2*coin_20

coin_10 = money//0.1
if(coin_10 > 0):
    print(int(coin_10), 'x 10 Cent')
    money = money - 0.1*coin_10

coin_5 = money//0.05
if(coin_5 > 0):
    print(int(coin_5), 'x  5 Cent')
    money = money - 0.05*coin_5

coin_2 = money//0.02
if(coin_2 > 0):
    print(int(coin_2), 'x  2 Cent')
    money = money - 0.02*coin_2

coin_1 = money//0.01
if(coin_1 > 0):
    print(int(coin_1), 'x  1 Cent')
    money = money - 0.01*coin_1

print('\n {} Münzen'.format(coin_2e+coin_1e+coin_50+coin_20+coin_10+coin_5+coin_2+coin_1))