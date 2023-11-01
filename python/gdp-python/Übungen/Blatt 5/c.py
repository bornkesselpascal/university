# Blatt 5, Aufgabe C

def reverse(zahl):
    components = []

    while zahl > 0:
        com = zahl % 10
        zahl = zahl // 10
        components.append(com)

    rev = 0
    for i in range(0, len(components)):
        rev += components[i]*10**(len(components)-i-1)

    return rev


print(reverse(1234567890000))