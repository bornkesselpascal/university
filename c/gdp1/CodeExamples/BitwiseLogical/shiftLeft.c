#include <stdio.h>
#include <stdlib.h>

int main (void){

  int a;

  printf("Geben Sie einen Hex-Wert (max 4 Byte) ein\n");
  printf("Format 0xFFFFFFFF\n");
  printf("Beispiel: 0x12\n");
  printf("Eingabe: ");

  if (scanf("0x%x",&a) != 1){
      printf("Fehlerhafte Eingabe\n");
      return EXIT_FAILURE;
  }

  // Hier haben wir den HexWert eingelesen und den Wert in a gepeichert
  
  printf("Sie haben folgenden Wert eingegeben: 0x%x\n", a);

  int count=0;
  while (count < 31 ){
    a = (a <<1);
    count++;
    printf("a <<%2d = 0x%08x\n", count,a);
  }

  return EXIT_SUCCESS;
}
