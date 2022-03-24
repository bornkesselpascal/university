// Dieses Programm kompiliert und funktioniert wie gewuenscht.
// Fuer Argumente und Resultat werden Pointer genutzt.
// Die Argumente werden per 'const' vor Veraenderung geschuetzt.
// Die Schnittstelle wird verbessert.
// Wir allokieren in der Funktion ad() per malloc() Speicher fuer das Resultat.
// Wir geben als Resultat von add()den Pointer auf das Resultat zurueck.
// Die Funktion kann jetzt schoener aufgerufen werden (Fluent Interface)

#include <stdio.h>
#include <stdlib.h>
#define OK 0
#define FAILURE 1

// Falls Struktur in mehreren Funktionen verwendet werden soll, muss sie
// im global Scope definiert werden! Sonst kennen die anderen Funktionen
// den Typ nicht.

struct complex {
    double re;
    double im;
};

// Addiere zwei komplexe Zahlen
// Die beiden Argumente werden per Pointer auf konstante Structuren uebergeben.
// Die Variable, die das Resultat aufnehmen soll, wird per malloc auf
// dem Heap erzeugt und ein Pointer auf das dynamische Object wird
// als Resultat zurueckgegeben.
// Diese Version ist effizient, sicher (wegen const) und elegant.
struct complex *
add(struct complex const *z1, struct complex const *z2) {
    // lokale Variable fuer Pointer auf Resultat
    struct complex *res;
    // Allokiere Speicher fuer das Ergebnis
    res = malloc(sizeof (struct complex));
    if (res == NULL) {
        printf("Kein Speicher mehr\n");
        exit(FAILURE);
    }

    (*res).re = (*z1).re + (*z2).re; // Alternative 1: Dereferenz '*' und dannach
                                     // Zugriff uber '.'
    res->im = z1->im + z2->im;       // Alternative 2: Dereferenz und Zugriff ueber '->'

    // z1->re = 0.0; // resultiert in Fehlermeldung des Compilers:
                     // error: assignment of read-only location ‘*z1’
    return res;
}

int main (void) {

    struct complex c1,c2;
    struct complex *c3, *c4, *c5;
    
    c1.re = 1.0;
    c1.im = 2.0;

    c2.re = 3.0;
    c2.im = 4.0;
    c5 = add( c3=add(&c1,&c2), c4=add(&c1,&c2)); // fluent interface von add()
    printf("c3 = (%f,%f)\n",c3->re, c3->im );
    printf("c4 = (%f,%f)\n",c4->re, c4->im );
    printf("c5 = (%f,%f)\n",c5->re, c5->im );
    
    free(c3);  // Speicher fuer Resultat zurueckgeben
    free(c4);  // Speicher fuer Resultat zurueckgeben
    free(c5);  // Speicher fuer Resultat zurueckgeben

    // Hinweis: ein gutes Betriebssystem gibt den allokierten Speicher auf dem Heap
    // bei Ende des Prozesses an OS zurueck. Das haengt aber vom Betriebssystem (OS) ab!
    // Unter Windows oder Linux ist free() in diesem Beispiel ueberfluessig.
    //
    // Es ist aber trotzdem schlechter Stil, den Speicher, den man per malloc()
    // allokiert, nicht explizit wieder freizugeben.
    // Memory-Leaks schleichen sich sonst zu leicht ein!
    // Besser immer selbst darum kuemmern, wie hier gezeigt.

    return OK;
}
