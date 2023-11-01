# Klassen und Objekte
#    - Alle Methoden einer Klasse müssen einen Parameter self haben, der das Objekt selbst referenziert.
#    - Der Konstruktor __init__ wird aufgerufen, wenn ein Objekt erzeugt wird.
#    - Attribtue werden mit self.attributname definiert und können dann mit self.attributname aufgerufen werden.

class Rechteck:
    # Klassenattribut
    #     - Zugriff mit KLASSENNAME.ATTRIBUTNAME
    farbe = 'rot'


    # Konstruktor (Attribute erstellen)
    def __init__(self, länge, breite):
        self.länge = länge
        # "Private"-Attribut (Zugriff nur aus Klasse, sonst von Überall) [Name Mangling]
        #      - Nutzung des @property-Decorators zum Zugriff von außen (nur Lesen)
        self.__breite = breite

    @property
    def breite(self):
        return self.__breite

    def fläche(self):
        return self.länge * self.__breite
    
    def umfang(self):
        return 2 * (self.länge + self.__breite)
    

    # Darstellung des Objekts beim verwenden von print()
    #      - Rückgabe eines Strings
    def __repr__(self) -> str:
        return f'Rechteck ({self.länge} x {self.__breite})'
    

    # Überladen von Operatoren
    #      - __add__(self, other) für +, __sub__(self, other) für -, __mul__(self, other) für *, __truediv__(self, other) für /, ...
    #      - __eq__(self, other) für ==, __ne__(self, other) für !=, __lt__(self, other) für <, __gt__(self, other) für >, ...
    #      - Rückgabe eines neuen Objekts oder True/False
    def __add__(self, other):
        länge = self.länge + other.länge
        breite = self.__breite + other.__breite
        return Rechteck(länge, breite)
    
    def __eq__(self, other) -> bool:
        return self.länge == other.länge and self.__breite == other.__breite
    
    def __ne__(self, other) -> bool:
        return self.länge != other.länge or self.__breite != other.__breite
    

    # Verwendung von Klassen in Sets, Dictionaries, …
    #     - Sets betrachten Objekte als gleich wenn * a==b * und der * Hash-Wert * gleich ist.
    #     - Neben __eq___ muss auch __hash__ implementiert werden.
    def __hash__(self) -> int:
        return hash((self.länge, self.__breite))
    

r1 = Rechteck(3,4)
r2 = Rechteck(8,1)

print(r1.fläche())
print(r1.umfang())

print(r1)
print(r1.breite)
print(r1.farbe)

print(r1 + r2)
print(r1 == r2)


# Vererbung
#     - Die erbende Klasse (Subklasse) erbt alle Attribute und Methoden der Elternklasse (Superklasse).
#     - Die erbende Klasse kann die Methoden der Elternklasse überschreiben.
#     - Die erbende Klasse kann den Konstruktor der Elternklasse mit super().__init__(...) aufrufen.

class Quadrat(Rechteck):
    def __init__(self, seite):
        super().__init__(seite, seite)

q = Quadrat(4)
print(q)