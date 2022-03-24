#include <stdio.h>
#include <string.h>

int main(void) {
  // Definition der Zeichenkette als Array von char.

  // Die Komponenten des Arrays sind sogn L-Werte.
  // L-Werte duerfen auch links von = stehen.
  // L-Werte beziehen sich auf ein Speicherobjekt.
  char s1[] = "Eine Xinfache Deichenkette";

  // Achtung: die Schreibweise ist eine Abkuerzung fuer
  // char s1[] = { 'E','i', ... ,'t','e','\0'};

  printf(" Vor der Korrektur: %s\n", s1);

  // Korrektur der Schreibfehler
  // Aenderung der Komponenten des Arrays ist erlaubt (L-Werte)
  s1[5] = 'e';
  s1[14] = 'Z';

  printf("Nach der Korrektur: %s\n", s1);

  return 0;
}
