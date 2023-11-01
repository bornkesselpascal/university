# Blatt 1, Aufgabe B

time_str = input('Sekunden: ')
time = int(time_str)

time_h = time//60//60
time_m = (time-time_h*60*60)//60
time_s = (time-time_h*60*60-time_m*60)
print(format(time_h, '02'),format(time_m, '02'),format(time_s, '02'), sep=':')