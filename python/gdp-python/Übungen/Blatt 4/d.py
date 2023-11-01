# Blatt 4, Aufgabe D

string = input('String    :')
part   = input('Teilstring:')

location = 0
occurence = 0
while part in string[location:]:
    occurence += 1
    while part != string[location:location+len(part)]:
        location += 1

    location += len(part)

print(f'"{part}" kommt in "{string}" {occurence} mal vor.')
