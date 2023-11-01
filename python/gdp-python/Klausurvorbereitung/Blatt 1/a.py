# Blatt 1, Aufgabe A

tem_c = float(input('Temperatur in Celsius: '))
print(f'{round(tem_c, 1)} Grad Celsius = {round((9/5)*tem_c+32,1)} Grad Fahrenheit')

print()

tem_f = float(input('Temperatur in Fahrenheit: '))
print(f'{round(tem_f, 1)} Grad Fahrenheit = {round((5/9)*(tem_f-32), 1)} Grad Fahrenheit')