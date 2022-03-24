/*
   Zweck von spy.c
   Wir schreiben C-Code für einen Test auf gerade/ungerade und spicken
   dann den erzeugten Assembler-Code

*/
#include <stdio.h>

int i1 = 15;

int main() {

  printf("i1 = %d\n", i1);
  return 0;
}
