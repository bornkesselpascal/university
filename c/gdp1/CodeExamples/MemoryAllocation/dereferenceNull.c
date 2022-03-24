// Frage:
// Kann man an der Adresse 0x00000000 zugreifen?
// Achtung: NULL == 0x00000000
//
// Aufgabe: das Programm im Debugger ausführen

#include<stdio.h>
#include<stdlib.h>

int main(void){
  
  int dummy;
  
  printf("Adresse = %p\n", (int*)0x00);
  //printf("Adresse = %p\n", (int*)0x100);
  //printf("Adresse = %p\n", (int*)0x10000);

  // Wir möchten auf die Adresse 0x00 zugreifen.
  // Syntaktisch ist nachfolgende Zeile korrekt.
  // Siehe dazu dereferenceAddress.c
  // Hier kracht es aber beim Zugriff: Segmentation fault
  dummy = *((int*)(0x00));
  //dummy = *((int*)(0x100));
  //dummy = *((int*)(0x10000));
  printf("Per Literal: dummy = %x\n", dummy);

  return EXIT_SUCCESS;
}

//
// Antwort: man kann an Adresse 0x0 nicht zugreifen
// An den niedrigen Adressen sind die meisten Speicherseiten
// für normale User-Prozesse gesperrt!
// Siehe Vorlesung Betriebssysteme.
//
// Erst an höhreren Adressen (zb &main) darf Prozess zugreifen.
// Dort sind die Speicherseiten zumindest 'lesbar'.
//
