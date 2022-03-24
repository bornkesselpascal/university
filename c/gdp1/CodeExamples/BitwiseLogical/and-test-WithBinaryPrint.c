#include <stdio.h>
#include <stdlib.h>

#include "tobinary.c"

int main (void){
  char buf[33];
  int a = 0b01;
  int b = 0b10;

  printf("a=0b%s\n", uint32tobin(a,buf) );
  printf("b=0b%s\n", uint32tobin(b,buf) );

  printf("logische Verknuepfung, Wert von a && b : 0b%s\n", uint32tobin(a && b, buf) );
  printf("bitweise Verknuepfung, Wert von a &  b : 0b%s\n", uint32tobin(a &  b, buf) );

  if ( a && b ) {
    printf("a && b wird interpretiert als logisch 'wahr'\n");
  } else {
    printf("a && b wird interpretiert als logisch 'falsch'\n");
  }

  if ( a & b ) {
    printf("a &  b wird interpretiert als logisch 'wahr'\n");
  } else {
    printf("a &  b wird interpretiert als logisch 'falsch'\n");
  }

  return EXIT_SUCCESS;
}
