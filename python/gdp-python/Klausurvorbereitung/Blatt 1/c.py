vorname  = input('Vorname : ')
nachname = input('Nachname: ')
alter    = int(input('Alter   : '))

spanne = (alter//10) * 10

print('\n', f'{vorname[0]}. {nachname} ({spanne} - {spanne+9})', sep='')