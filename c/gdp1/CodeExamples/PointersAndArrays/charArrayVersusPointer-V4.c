#include <stdio.h>
#include <string.h>

int main(void) {
  // Ein nicht-konstanter Pointer (hier s1) kann waehrend seiner 
  // Lebensdauer auf unterschiedliche Dinge zeigen.

  char *s1 = "Eine konstante Zeichenkette";

  // Der Basis-Pointer eines char[] dagegen kann nicht umgesetzt werden
  char s2[] =
    "s2 ist ein konstanter Pointer auf ein veraenderbares Array von char";

  printf("%s\n",s2);

  printf("Worauf zeigt s1?:%s\n", s1);

  s1 = "Eine andere konstante Zeichenkette";

  printf("Worauf zeigt s1?:%s\n", s1);

  // Folgende Anweisung fuehrt zu Fehlermeldung des Compilers:
  // incompatible types when assigning to type 'char[68]' 
  // from type 'char *'
  //
  //s2 = "Eine andere konstante Zeichenkette";

  return 0;
}
