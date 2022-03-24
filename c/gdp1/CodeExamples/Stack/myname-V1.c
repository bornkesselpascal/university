#include <stdio.h>

int main() {
  int  x = 0x11223344;
  char *name = "Philomena";
  int  y = 0x55667788;

  printf("Mein Name lautet %s\n", name);

  x++; y++;
  name[1] = 0x65;
  return 0;
}
