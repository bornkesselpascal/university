#include <stdio.h>
#include <string.h>

int main(void) {
  // Folgende Definition bewirkt, dass s2 ein Pointer
  // auf das char Array s1 wird. Das Array s1 ist als L-Wert definiert.
  char s1[] = "Eine Xinfache Deichenkette";
  char *s2;

  s2 = s1;

  printf(" Vor der Korrektur: %s\n", s1);

  // Korrektur der Schreibfehler
  // Nun kann man auch Ueber den Pointer s2 die Komponenten des Arrays
  // aendern.

  *(s2 + 5) = 'e';
  s2[14] = 'Z';

  printf("Nach der Korrektur: %s\n", s1);

  return 0;
}
