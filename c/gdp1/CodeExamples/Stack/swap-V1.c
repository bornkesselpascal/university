/*
  swap in Version 1

  Die Loesung ist falsch, da die beiden Parameter per Wert uebergeben werden.
  Diese Variante wurde speziell fuer die Betrachtung in einem Debugger konzipiert.
  Die Wert sind so gewaehlt, dass sie im Hex-Dump auffallen.

 */

#include <stdio.h>

void swap(int a, int b) {
    int tmp = a;
    a = b;
    b = tmp;
}

int main() {
    int i1,i2;

    i1=0x11223344;
    i2=0x55667788;

    swap(i1,i2);

    printf("After swap\n");
    printf("i1: %d\n",i1);
    printf("i2: %d\n",i2);

    return 0;
}
