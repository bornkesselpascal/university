// Demonstrate the memory layout of one-dimensional arrays.
//
// In the debugger
// (gdb) break dumpArray_1dim
// (gdb) run 
// (gdb) x /8xw &main::theArray

#include <stdio.h>

#define ARRAY_SIZE 5
#define OK 0

void dumpArray_1dim(int anArray[], int size) {
  int i;
  printf("Base address is %p\n", anArray);
  for (i=0; i<size; i++){
    printf("at index %d: address=%p content=%08x\n",
        i, &anArray[i], anArray[i]);
  }
}

int main() {
  int theArray[ARRAY_SIZE]={
    0x00000000,
    0x11111111,
    0x22222222,
    0x33333333,
    0x44444444,
  };

  dumpArray_1dim(theArray, ARRAY_SIZE);
  return OK;
}

