# Blatt 5, Aufgabe C

def reverse(zahl: int) -> int:
    new = 0
    while(zahl > 0):
        new = new*10 + zahl % 10
        zahl = zahl // 10

    return new


print(reverse(123456789000))