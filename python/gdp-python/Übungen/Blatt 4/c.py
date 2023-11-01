# Blatt 4, Aufgabe C

name = input('Name: ')

li = name.split(' ')
result = ''

for wort in li[::-1]:
    result = result + wort + ", "

print(result[:-2])