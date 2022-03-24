#include <stdio.h>

int main() {
  // Ein String
  char   *m = "Maus";
  // So wird "Maus" als konstante Zeichenkette definiert
  // Es sind keine Aenderungen am String erlaubt!
  // Der Pointer m ist nicht konstant. Er darf umgesetzt werden.

  // Und noch ein String
  char m2[] = "Mais";
  // m2 ist die konstante Basisadresses des
  // char-Arrays {'M','a','i','s','\0'}.
  // m2 ist kein Pointer, der umgesetzt werden koennte.
  // Die Zeichen im String duerfen aber veraendert werden.

  char *pc;

  pc = m;
  // Zuweisung char* an char* ist ganz normal und OK

  // *(pc+2) = 'i';
  // Vohergehende Zeile fuehrt zur Laufzeit zu einem
  //     'Speicherzugriffsfehler' !
  // Der String darf nicht veraendert werden. 
  // pc[2] = 'i';     // Das gleiche Problem.
  // m[2] = 'i';      // Das gleiche Problem.

  pc = m2;       // Zuweisung char[] an char* ist ganz normal und OK.
  *(pc+2) = 'u'; // Das ist erlaubt, da m2 kein konstantes Array ist.

  printf("Aus Mais wird %s\n", m2);
  printf("Und %s bleibt %s\n", m,m);

  m = m2;        // Das ist auch erlaubt: Pointer m ist nicht konstant

  //m2 = m;
  // Vorherige Zeile ist nicht erlaubt:
  // m2 ist immer die Basisadresse des Arrays und kann nicht veraendert
  // werden
  // Anweisung resultiert in Fehler beim Kompilieren:

  return 0;
}

