#include <stdio.h>
#include <string.h>

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

int main(void) {
    // Wir definieren eine Variable der 'struct addresse' und initialisieren sie gleich
    struct adresse addr1 = {"Jam Alley"   ,"2"   ,73210,"Gotham City"};

    // Wir definieren eine Variable der 'struct addresse' und weisen die
    // Werte danach getrennt zu.
    struct adresse addr2;

    // Wir definieren zwei Variablen der 'struct student'
    struct student stud1;
    struct student stud2;

    // Zugriff auf Komponenten einer Struktur ueber den Operator '.'
    // zB: addr2.strasse oder addr.postleitzahl

    // Komponenten vom typ char[] koennen zB per strcpy zugewiesen werden
    strcpy(addr2.strasse, "Komaweg");
    strcpy(addr2.stadt, "Bruchtal");
    // Es geht aber auch umstaendlicher per char Zuweisung
    // Achtung: Terminierung durch '\0' notwendig
    addr2.hausnummer[0] = '4';
    addr2.hausnummer[1] = '\0';

    // Komponenten mit primitivem Typ koennen direkt zugewiesen werden.
    // zB Komponente 'int postleitzahl'
    addr2.postleitzahl = 98765;

    // Zuweisung an die Strukturvariable struct student stud1
    strcpy(stud1.matrikelnummer,"00001");
    strcpy(stud1.studiengang,"IB");
    strcpy(stud1.nachname,"Munter");
    strcpy(stud1.vorname,"Monika");
    stud1.wohnort = addr1; // Strukturen koennen als ganzes zugewiesen werden!

    // Zuweisung an die Strukturvariable struct student stud2
    strcpy(stud2.matrikelnummer,"00002");
    strcpy(stud2.studiengang,"IB");
    strcpy(stud2.nachname,"Tragel");
    strcpy(stud2.vorname,"Lars");
    stud2.wohnort = addr2; // Strukturen koennen als ganzes zugewiesen werden!

    // Lesender Zugriff: Beispiel Ausgabe

    // Kopfzeile
    printf("%6s%5s%21s%21s%21s%6s%6s%20s\n\n",
           "MatNr","StGg","Nachname","Vorname","Strasse","HNr","PLZ","Stadt");

    printf("%6s%5s%21s%21s%21s%6s%6d%20s\n",
            stud1.matrikelnummer,
            stud1.studiengang,
            stud1.nachname,
            stud1.vorname,
            stud1.wohnort.strasse,       // Zugriff ueber '.' auch mehrstufig!
            stud1.wohnort.hausnummer,
            stud1.wohnort.postleitzahl,
            stud1.wohnort.stadt
            );

    printf("%6s%5s%21s%21s%21s%6s%6d%20s\n",
            stud2.matrikelnummer,
            stud2.studiengang,
            stud2.nachname,
            stud2.vorname,
            stud2.wohnort.strasse,
            stud2.wohnort.hausnummer,
            stud2.wohnort.postleitzahl,
            stud2.wohnort.stadt
            );

    return OK;
}
