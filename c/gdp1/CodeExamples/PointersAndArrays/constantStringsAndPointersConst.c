// Verwendung des Modifizierers 'const'
// Vorteil: Fehler werden schon vom Compiler gemeldet
#include <stdio.h>

int main() {
  // Ein String
  const char* m = "Maus";
  // So wird "Maus" als konstante Zeichenkette definiert.
  // Es sind keine Aenderungen am String erlaubt!
  // Der Pointer m ist nicht konstant. Er darf umgesetzt werden.

  // Und noch ein String
  char m2[] = "Mais";
  char* const pm2 = m2;
  // So wird pm2 als konstanter Pointer auf die Basisadresses des
  // char-Arrays {'M','a','i','s','\0'} definiert.
  // Der Pointer darf nicht umgesetzt werden.
  // Die Zeichen im String duerfen aber veraendert werden.

  //m[2] = 'i';       // Das fuehrt wegen 'const' zu Compiler-Fehler
  // error: assignment of read-only location '*(m + 2u) 
  // Compiler prueft sogenannte 'const correctness'.
  pm2[2] = 'u';
  printf("Aus Mais wird %s\n", m2);
  printf("Und %s bleibt %s\n", m,m);

  //pm2 = m;
  // Das ist nicht erlaubt: Pointer pm2 muss immer auf sein Array zeigen.
  // Anweisung resultiert in Fehlermeldung beim Kompilieren:
  // error: assignment of read-only variable 'pm2'
  return 0;
}

