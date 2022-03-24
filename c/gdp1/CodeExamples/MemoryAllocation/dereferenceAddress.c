// Frage:
// Kann man einfach im Code-Segment auf Adressen zugreifen?

#include<stdio.h>
#include<stdlib.h>

int main(void){
  
  int dummy;
  int *addr1;
  
  // &main ist die Adresse, an der die Funktion main beginnt

  printf("Adresse = %p\n", &main);
  // Dereference der Adresse und dort einen int auslesen
  dummy = *( (int*)(&main) );   // Cast (int*) ist notwendig
  printf("Per &main: dummy = %x\n", dummy);

  // Nun geben wir &main explizit als Literal ein
  printf("Adresse = %p\n", (int*)0x804841d);
  dummy = *((int*)(0x804841d));
  printf("Per Literal: dummy = %x\n", dummy);

  // Nun per Pointer addr1
  addr1 = (int*) 0x804841d;
  printf("Adresse = %p\n", addr1);
  dummy = *addr1;
  printf("Per Pointer addr1: dummy = %x\n", dummy);

  return EXIT_SUCCESS;
}
