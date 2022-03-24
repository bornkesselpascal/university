#include<stdio.h>

int main (void)  {
  int d;
  int a[5] = {0,1,2,3,4};
  int *pi1, *pi2;

  pi1 = &a[1];        // alternativ:  a + 1
  pi2 = &a[4];        // alternativ:  a + 4

  d = pi2 - pi1;      // Differenz der beiden Pointer auf Array a

  printf("\nPointer-Differenz von\n"
      "int *pi2 at %p und\n"
      "int *pi1 at %p ist\n"
      "            %14d\n"
      "Das sind %d Speicherzellen @ %d Bytes\n",
      pi2,pi1,d,d,(int) sizeof(int) );

  return 0; 
}
