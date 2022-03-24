#include <stdio.h>
#define OK 0

int main(void) {
  char s1[] = "Ron Weasley";
  char film_figur[13] = "Harry Po";
  char s2[] = "Hermione Granger";

  printf("Zeichenkette s1: %s\n", s1);
  printf("Name der Filmfigur: %s\n", film_figur);
  printf("Zeichenkette s2: %s\n", s2);

  // Terminate the string film_figur at an earlier position
  film_figur[5] = '\0';

  printf("Name der Filmfigur: %s\n", film_figur);

  // enlarge string
  film_figur[5]  = ' ';

  film_figur[8]  = 't';
  film_figur[9]  = 't';
  film_figur[10] = 'e';
  film_figur[11] = 'r';
  film_figur[12] = '\0';

  printf("Name der Filmfigur: %s\n", film_figur);

  // delete terminating '\0'
  // What will happen?
  film_figur[12] = '+';
  printf("Name der Filmfigur: %s\n", film_figur);

  return OK;
}
