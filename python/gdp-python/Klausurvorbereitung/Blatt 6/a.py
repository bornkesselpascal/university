# Blatt 6, Aufgabe A

def spleißen(rns: str, start: str, end: str) -> str:
    
    result = rns

    while result.find(start) != -1:
        count = result.find(start)
        count_end = result.find(end, count)
        result = result[:count] + result[count_end+len(end):]

    return result



rns = 'AUAGUAAAAGCUCUGUUUAGGAGA'
boten_rns = spleißen(rns, 'GU', 'AG')
print(rns)
print(boten_rns)