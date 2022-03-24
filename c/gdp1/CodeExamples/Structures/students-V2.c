#include <stdio.h>

#define OK 0
#define FAILURE 1

struct adresse {
    // Alle char[] sind '\0' terminierte Strings.
    // Hinweis: besser waeren char*, aber das macht es ein bischen komplizierter.
    // Das sparen wir auf fuer eine spaetere Version.
    char strasse[20];
    char hausnummer[5];
    int  postleitzahl;
    char stadt[20];
};  // Der abschliessende ';' ist wichtig!

struct student {
    char matrikelnummer[6]; // char[] wegen fuehrender Nullen in Matrikelnummern
    char studiengang[5];
    char nachname[20];
    char vorname[20];
    struct adresse wohnort; // Komponententyp ist selbst eine Struktur!
};

//void druckeSemester(struct student sem[5], int anz) {
void druckeSemester(struct student sem[], int anz) {
    int i;
    // Verstaendnisfrage: welche Zahl gibt das naechste Statement aus?
    // Wieso?
    //printf("Size of sem:%d\n",(int) sizeof(sem));

    // Kopfzeile
    printf("%6s%5s%21s%21s%21s%6s%6s%20s\n\n",
        "MatNr","StGg","Nachname","Vorname","Strasse","HNr","PLZ","Stadt");
    for (i=0; i<anz; i++) {
        printf("%6s%5s%21s%21s%21s%6s%6d%20s\n",
            sem[i].matrikelnummer,
            sem[i].studiengang,
            sem[i].nachname,
            sem[i].vorname,
            sem[i].wohnort.strasse,
            sem[i].wohnort.hausnummer,
            sem[i].wohnort.postleitzahl,
            sem[i].wohnort.stadt
            );
    }
}

int main(void) {
    // Wir definieren ein Array mit Elementen der 'struct student'
    // Explizite Initialisierung von Strukturen erfolgt analog zur Initialisierung
    // von Arrays über {...}.
    // Arrays und Strukturen sind beides Aggregat-Typen
    struct student ib_SS2011[] = {
        {"00001", "IB", "Munter","Monika",{"Jam Alley"   ,"2"   ,73210,"Gotham City"}},
        {"00002", "IB", "Tragel","Lars"  ,{"Komaweg"     ,"4"   ,98765,"Bruchtal"}},
        {"00003", "IB", "Trom"  ,"Peter" ,{"Opernstrasse","25a" ,43210,"Synphonia"}},
        {"00004", "IB", "Eckel" ,"Claude",{"Rohrweg"     ,"123b",82163,"Badenbaden"}},
        {"00005", "IB", "Meter" ,"Milli" ,{"Distanzgasse","18c" ,62554,"Laengental"}},
    };

    // Die Anzahl der Elemente im Array ib_SS2011 kann errechnet werden.
    // Gesamter Platzbedarf des Arrays geteilt durch Anzahl Bytes pro Element.
    // Achtung: das geht nur, wenn der Compiler die Groesse des Arrays kennt.
    // Hier dem Compiler bekannt wegen expliziter Initialisierung.
    druckeSemester(ib_SS2011, sizeof(ib_SS2011)/sizeof(struct student));
    return OK;
}
