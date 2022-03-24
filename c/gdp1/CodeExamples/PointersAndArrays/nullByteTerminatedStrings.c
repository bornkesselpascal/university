#include <stdio.h>
#define OK 0

int main(void) {
  char film_figur[] = "Harry Potter";

  printf("Name der Filmfigur: %s\n", film_figur);

  film_figur[5] = '\0';

  printf("Name der Filmfigur: %s\n", film_figur);

  film_figur[5] = ':';

  printf("Name der Filmfigur: %s\n", film_figur);

  return OK;
}
