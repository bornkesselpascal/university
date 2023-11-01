def spleißen(rns, start, ende):

    while rns.find(start) != -1:
        start_idx = rns.find(start)
        ende_idx  = rns.find(ende, start_idx)

        rns = rns[:start_idx] + rns[ende_idx+len(ende):]

    return rns


rns = 'AUAGUAAAAGCUCUGUUUAGGAGA'
boten_rns = spleißen(rns, 'GU', 'AG')
print(rns)
print(boten_rns)