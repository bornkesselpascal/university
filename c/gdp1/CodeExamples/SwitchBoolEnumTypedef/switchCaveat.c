#include <stdio.h>
#include <stdlib.h>

int main(void){
  int val = 3;

  switch(val) {
    case 1:
      printf("Fall 1\n");
      break;
    case 2:
    case 3:
      printf("Fall 2 oder 3\n");
      //break;
    case 4:
      printf("Fall 4\n");
      break;
    default:
      printf("Zweig default: kein expliziter Fall für %d festgelegt\n", val);
  }
  return EXIT_SUCCESS;
}
