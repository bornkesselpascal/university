# Blatt 11, Aufgabe A

class Konto:
    def __init__(self):
        self.kontostand = 0
        self.dispolimit = 0
        self.umsätze = list()

        self.summe_einzahlungen = 0
        self.anzahl_einzahlungen = 0

    def einzahlen(self, betrag: int) -> None:
        if betrag < 0: raise BaseException('Betrag ungültig')

        self.kontostand += betrag
        self.umsätze.insert(0, betrag)
        self.summe_einzahlungen += betrag
        self.anzahl_einzahlungen += 1

        if self.anzahl_einzahlungen == 3:
            self.dispolimit = round(self.summe_einzahlungen // 3, -3)
    
    def auszahlen(self, betrag: int) -> int:
        if betrag < 0: raise BaseException('Betrag ungültig')

        if(self.kontostand + self.dispolimit) >= betrag:
            self.kontostand -= betrag
            self.umsätze.insert(0, -betrag)
            return betrag
        else:
            auszahlung = self.kontostand + self.dispolimit
            self.kontostand -= auszahlung
            self.umsätze.insert(0, -auszahlung)
            return auszahlung
        
    def get_umsätze(self, n: int) -> list[int]:
        return self.umsätze[:5]
    

konto = Konto()
konto.einzahlen(800)
konto.auszahlen(620)
konto.einzahlen(278)
konto.auszahlen(5000)
konto.einzahlen(1517)
konto.auszahlen(1855)
print()
print("Umsätze :", konto.get_umsätze(5))
print("Kontostand:", konto.kontostand)
print("Dispolimit:", konto.dispolimit)