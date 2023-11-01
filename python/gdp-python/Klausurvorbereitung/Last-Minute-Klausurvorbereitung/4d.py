string     = 'ein kleines feines Beispiel'
teilstring = 'ein'

print(string.count(teilstring))

i = occ = 0
while teilstring in string[i:]:
    occ += 1
    while teilstring != string[i:i+len(teilstring)]:
        i += 1

    i += len(teilstring)

print(occ)