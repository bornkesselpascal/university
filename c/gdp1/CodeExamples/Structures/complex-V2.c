// Dieses Programm kompiliert und funktioniert wie gewuenscht.
// Fuer Argumente und Resultat werden Pointer genutzt.

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
// Die beiden Argumente werden per Pointer uebergeben.
// Die Variable, die das Resultat aufnehmen soll, wird ebenfalls per Pointer
// ubergeben. Diese Version ist effizient.
// Einziger Nachteil: Argumente koennen in Funktion veraendert werden.
// Bei einer Funktion wie add() ist das sicher nicht erwuenscht.
void add(struct complex *z1, struct complex *z2, struct complex *res) {
    (*res).re = (*z1).re + (*z2).re; // Alternative 1: Dereferenz '*' und dannach
                                     // Zugriff uber '.'
    res->im = z1->im + z2->im;       // Alternative 2: Dereferenz und Zugriff ueber '->'
}

int main (void) {

    struct complex c1,c2,c3;

    c1.re = 1.0;
    c1.im = 2.0;

    c2.re = 3.0;
    c2.im = 4.0;

    add(&c1,&c2,&c3); // Uebergabe der Argumente und des Resultat-Objekts per Pointer
    printf("c3 = (%f,%f)\n",c3.re,c3.im);

    return OK;
}
