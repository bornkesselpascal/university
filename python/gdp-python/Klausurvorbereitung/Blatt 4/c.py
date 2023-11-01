# Blatt 4, Aufgabe C

name = input('Name: ')
components = name.split(' ')

if len(components) >= 2:
    print(components[-1],', ', ' '.join(components[0:len(components)-1]), sep='')
else:
    print(name)