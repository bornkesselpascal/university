#include <stdio.h>

int main() {
  // Ein String, der nicht verändetr werden darf
  // m ist ein Pointer auf den String
  char   *m = "Maus";
  // Ein paar Pointer mit unterschiedlichem Typ
  void *pv;
  char *pc;
  int  *pi;

  // Wir lassen den char-Pointer pc auf die gleiche Adresse zeigen wie m
  pc = m;  // Zuweisung char* and char* OK

  // Ausgabe zeichenweise mit Offset zum Basis-Pointer
  printf("Character:%c %c %c %c\n",*pc, *(pc+1), *(pc+2), *(pc+3));

  /*
     Die einzelne Buchstaben des Strings "Maus" liegen dicht im Speicher.
     Ueber den Umweg eines void-Pointers lassen wir den int Pointer pi
     auf die gleiche Adresse wie m zeigen. Beide zeigen damit auf die
     Basisadresse des Strings "Maus".
     Danach interpretieren wir die 4 Byte des Strings "Maus" als Integer
     */

  pv = m;  // Zuweisung von char* an void*;
  // Erlaubt, aber wir verlieren Typinformation!
  pi = pv; // Zuweisung von void* an int* ist erlaubt.
  // Wir fuehren neue Typinformation ein.

  // Ausgabe der uminterpretierten Speicherzellen als Speicherobjekt
  // vom Typ int
  printf("String '%s' interpretiert als int hat den Wert: %d\n", m, *pi);

  // Erklaerung:
  // Ascii-Code: 'M' = 77 ; 'a' = 97; 'u' = 117 ; 's' = 115
  // 
  printf("\nErklaerung:\n");
  printf("'M'=%d,'a'=%d,'u'=%d,'s'=%d\n%d + 256 * %d" 
      " + 256*256*%d + 256*256*256*%d = %d\n",
      'M','a','u','s', 'M','a','u','s',
      'M' + 'a'*256 + 'u'*256*256 + 's' *256*256*256);

  return 0;
}

