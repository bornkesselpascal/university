#include <stdio.h>
#include <stdlib.h>


int main (void){

  int a = 0b01;
  int b = 0b10;

  printf("a=0x%x\n", a);
  printf("b=0x%x\n", b);

  printf("logische Verknuepfung, Wert von XOR(a,b) : 0x%0x\n", a && b);
  printf("bitweise Verknuepfung, Wert von      a^b : 0x%0x\n", a &  b);

  if ( a && b ) {
    printf("a && b wird interpretiert als logisch 'wahr'\n");
  } else {
    printf("a && b wird interpretiert als logisch 'falsch'\n");
  }

  if ( a & b ) {
    printf("a & b wird interpretiert als logisch 'wahr'\n");
  } else {
    printf("a & b wird interpretiert als logisch 'falsch'\n");
  }

  return EXIT_SUCCESS;
}
