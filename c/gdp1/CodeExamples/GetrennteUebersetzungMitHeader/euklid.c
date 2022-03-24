#include <stdio.h>
#include <stdbool.h>

#include "readInteger.h"
#include "euklid.h"

// Globale Variablen
bool debug = true;

// Die Hauptfunktion main()

int main (void) {
    int i1;
    int i2;
    int theGGT;

    /* Lies zwei ganze Zahlen in i1 und i2 ein */
    printf("Bitte geben Sie zwei ganze Zahlen ein\n");

    if(readInteger("Bitte die erste Zahl i1=", &i1) != OK ) {
        printf("Fehler bei der Eingabe der Zahl i1\n");
        return ERROR;
    }

    if(readInteger("Bitte die zweite Zahl i2=", &i2) != OK ) {
        printf("Fehler bei der Eingabe der Zahl i2\n");
        return ERROR;
    }

    // Berechne GGT
    theGGT = ggT(i1,i2);

    // Ausgabe des Resultats
    printf ("Der groesste gemeinsame Teiler von %d und %d ist: %d\n",
             i1,i2,theGGT);

    return OK;
}

// Hilfsfunktionen

int ggT(int a, int b) {
    // Fix fuer negative Zahlen
    if (a < 0) { a = -a; }
    if (b < 0) { b = -b; }

    while (a != b) {
        if (a < b)
            b = b - a;
        else
            a = a - b;
    }
    return a;
}

