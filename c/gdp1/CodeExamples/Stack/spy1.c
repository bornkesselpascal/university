/*
   Zweck von spy.c
   Wir schreiben C-Code für einen Test auf gerade/ungerade und spicken
   dann den erzeugten Assembler-Code

*/
#include <stdio.h>

int i1 = 15;

int main() {

  // Test: ist i1 gerade?
  if( i1%2 ){
    printf("i1 ist ungerade\n");
  } else {
    printf("i1 ist gerade\n");
  }
  return 0;
}
