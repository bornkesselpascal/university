# Blatt 11, Aufgabe B

class Schachspiel:
    def __init__(self):
        self.spielbrett = [
            ['t', 's', 'l', 'd', 'k', 'l', 's', 't'],
            ['b']*8,
            [' ']*8,
            [' ']*8,
            [' ']*8,
            [' ']*8,
            ['B']*8,
            ['T', 'S', 'L', 'D', 'K', 'L', 'S', 'T']
        ]

    def ziehe(self, zug):
        zug_liste = zug.split('-')

        print(zug_liste)
        
        von = self.spielbrett[8-int(zug_liste[0][-1])][(ord(zug_liste[0][-2])-ord('a'))]
        self.spielbrett[8-int(zug_liste[1][1])][(ord(zug_liste[1][0])-ord('a'))] = von
        self.spielbrett[8-int(zug_liste[0][-1])][(ord(zug_liste[0][-2])-ord('a'))] = ' '

    def __repr__(self) -> str:
        bezeichner = '    a   b   c   d   e   f   g   h \n'
        striche = '  ---------------------------------\n'
        trenner = ' | '

        spiel = bezeichner + striche
    
        for i in range(0, 8):
            spiel += str(8-i) + trenner
            spiel += trenner.join(self.spielbrett[i])
            spiel += trenner + str(8-i) + '\n'
            spiel += striche

        spiel += bezeichner + trenner

        return spiel

spiel = Schachspiel()
print(spiel)
spiel.ziehe("e2-e4")
spiel.ziehe("e7-e5")
spiel.ziehe("Sg1-f3")
spiel.ziehe("Sb8-c6")
spiel.ziehe("Lf1-c4")
spiel.ziehe("Lf8-c5")
print(spiel)