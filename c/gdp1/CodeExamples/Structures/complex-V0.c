// Achtung: dieses Programm kompiliert nicht
// Es enthaelt einen Denkfehler. Welchen?

#include <stdio.h>
#define OK 0

// Addiere zwei komplexe Zahlen
struct complex add(struct complex z1, struct complex z2) {
    struct complex res;
    res.re = z1.re + z2.re;
    res.im = z1.im + z2.im;
    return res;
}

int main (void) {

    struct complex {
        double re;
        double im;
    } c1,c2;
    struct complex c3;

    c1.re = 1.0;
    c1.im = 2.0;

    c2.re = 3.0;
    c2.im = 4.0;

    c3 = add(c1,c2);
    printf("c3 = (%f,%f)\n",c3.re,c3.im);

    return OK;
}
