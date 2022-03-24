#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {

  char* s1="Annalena";
  char* s2="Anna";
  char* s3="Anderl";
  char* s4="AnDerl";

  printf("Vergleich %s mit %s liefert %d\n", s1,s2,strcmp(s1,s2));
  printf("Vergleich %s mit %s liefert %d\n", s1,s3,strcmp(s1,s3));
  printf("Vergleich %s mit %s liefert %d\n", s4,s3,strcmp(s4,s3));

  printf("Code-Diff %c - %s = %d\n", 'l', "\\0", 'l' - '\0');
  printf("Code-Diff %c - %c = %d\n", 'n', 'd', 'n' - 'd');
  printf("Code-Diff %c - %c = %d\n", 'D', 'd', 'D' - 'd');

  return EXIT_SUCCESS;
}
