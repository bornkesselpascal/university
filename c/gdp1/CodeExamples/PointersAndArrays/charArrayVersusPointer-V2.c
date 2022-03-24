#include <stdio.h>
#include <string.h>

int main(void) {
  // Achtung: die folgende Definition bewirkt, dass s1 ein Pointer
  // auf eine konstante Zeichenkette wird.
  // Die Zeichenkette ist ein sogn. R-Wert (darf nur rechts von = stehen)
  char *s1 = "Eine Xinfache Deichenkette";

  printf(" Vor der Korrektur: %s\n", s1);

  // Korrektur der Schreibfehler
  // Beide Anweiungen fuehren zu Laufzeitfehlern (Speicherzugriffsfehler)
  // Jeder Versuch, die Zeichenkette zu veraendern fuehrt zu einem
  // Laufzeitfehler.

  *(s1 + 5) = 'e';
  s1[14] = 'Z';

  printf("Nach der Korrektur: %s\n", s1);

  return 0;
}
