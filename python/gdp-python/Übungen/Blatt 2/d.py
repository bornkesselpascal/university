w1 = input('1. Wort: ')
w2 = input('2. Wort: ')
w3 = input('3. Wort: ')

wörter = [w1, w2, w3]
wörter.sort()

print('\nsortiert:', end=' ')
for wort in wörter:
    print(wort, end=' ')