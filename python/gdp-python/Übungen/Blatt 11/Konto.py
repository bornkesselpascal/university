"""Programmieren mit Python"""

class Konto:
    def __init__(self):
        self.kontostand = 0
        self.dispolimit = 0
        self.umsätze = []
        self.dispocalc = []

    def einzahlen(self, betrag: int) -> None:
        self.kontostand += betrag
        self.umsätze.insert(0, betrag)

        self.dispocalc.append(betrag)
        if(len(self.dispocalc) == 3):
            self.dispolimit = int(round(sum(self.dispocalc)/3, -3))
            # Nice2Know - round mit -3 rundet auf nächsten 1000, round mit 1 auf 0.1
            
    def auszahlen(self, betrag: int) -> int:
        if(betrag <= (self.kontostand + self.dispolimit)):
            self.kontostand -= betrag
            self.umsätze.insert(0, -betrag)
            return betrag
        else:
            auszahlung = self.kontostand + self.dispolimit
            self.kontostand = -self.dispolimit
            self.umsätze.insert(0, -auszahlung)
            return auszahlung
        
    def get_umsätze(self, n: int) -> list[int]:
        rev = list(reversed(self.umsätze))
        return self.umsätze[:n]
    

konto = Konto()
konto.einzahlen(800)
konto.auszahlen(620)
konto.einzahlen(278)
konto.auszahlen(5000)
konto.einzahlen(1517)
konto.auszahlen(1855)
print()
print("Umsätze   :", konto.get_umsätze(5))
print("Kontostand:", konto.kontostand)
print("Dispolimit:", konto.dispolimit)
