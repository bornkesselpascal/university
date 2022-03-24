// Show that void pointer cannot be dereferenced

#include<stdio.h>

int main (void)  {
  int d;
  int a[5] = {0,1,2,3,4};
  void *pv1, *pv2;

  pv1 = a;  // OK

  pv2 = pv1 + 3;  // OK !!
  // Seems that gcc implicitly assumes 1 byte
  // as unit when doing arithmetics with void*

  d = pv2 - pv1;  // OK !!

  printf("  a     is at %p\n", a);
  printf("pv1 points to %p\n", pv1);
  printf("pv2 points to %p\n", pv2);
  printf("pv2 - pv1 is: %d\n", d);

  // *pv1 = 17;
  // voidPointer.c:20:5: warning: dereferencing 'void *' pointer
  // voidPointer.c:20:5: error: invalid use of void expression

  // d = *pv2;
  // voidPointer.c:25:9: warning: dereferencing 'void *' pointer
  // voidPointer.c:25:7: error: void value not ignored as it ought to be

  return 0; 
}
