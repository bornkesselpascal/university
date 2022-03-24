// Dieses Programm kompiliert und funktioniert wie gewuenscht.
// Die Verwendung der Call-By-Value Semantik von Strukturen ist
// aber unueblich.
// Bei grossen Strukturen ist das Kopieren der Strukturen
// beim Aufruf und bei der Rueckgabe nicht performant genug.

#include <stdio.h>
#define OK 0

// Falls Struktur in mehreren Funktionen verwendet werden soll, muss sie
// im global Scope definiert werden! Sonst kennen die anderen Funktionen
// den Typ nicht.

struct complex {
    double re;
    double im;
};

// Addiere zwei komplexe Zahlen
// Die beiden zu addierenden Zahlen werden per-value uebergeben!
// Beim Aufruf der Funktion wird also eine Kopie der Strukturen gemacht.
struct complex add(struct complex z1, struct complex z2) {
    struct complex res;
    res.re = z1.re + z2.re;
    res.im = z1.im + z2.im;
    // Achtung: hier wird der Wert der lokalen Variablen res (hier eine Struktur)
    // zurueckgegeben. Es wird eine Kopie erzeugt und diese Kopie wird zurueckgegeben.
    return res;
}

int main (void) {

    struct complex c1,c2,c3;

    c1.re = 1.0;
    c1.im = 2.0;

    c2.re = 3.0;
    c2.im = 4.0;

    c3 = add(c1,c2); // Der Resultatwert von add(c1,c2) ist eine Struktur
                     // Zuweisung einer Kopie an c3
    printf("c3 = (%f,%f)\n",c3.re,c3.im);

    return OK;
}
