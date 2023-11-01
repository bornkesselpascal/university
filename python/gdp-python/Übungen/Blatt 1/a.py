# Blatt 1, Aufgabe A

temp_c_str = input('Temperatur in Celsius: ')
temp_c = float(temp_c_str)

temp_f = (9/5)*temp_c+32
print('{} Grad Celsius = {} Grad Fahrenheit'.format(round(temp_c, 1), round(temp_f, 1)))

print()

temp_f_str = input('Temperatur in Celsius: ')
temp_f = float(temp_f_str)

temp_c = (5/9)*(temp_f-32)
print('{} Grad Fahrenheit = {} Grad Celsius'.format(round(temp_f, 1), round(temp_c, 1)))