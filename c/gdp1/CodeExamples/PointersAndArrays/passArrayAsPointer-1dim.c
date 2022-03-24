// Demonstrate that arrays are always passed by reference
// Access the array via pointer and use pointer arithmetics

#include <stdio.h>

#define ARRAY_SIZE 10
#define OK 0

// Replace all odd numbers in the array by 0
// Parameters:
// (REF) anArray: the array to be processed passed via pointer
// (VAL)   asize: the size of the array
void replaceTheOddNumbers(int *anArray, int asize) {
  int i;

  for(i=0; i<asize; i++) {
    if ( (*(anArray+i) % 2) != 0) {
      printf("Cleaning at index %d at address %p\n",i,anArray+i);
      // Alternative syntax: anArray[i]
      // No difference in 1-dimensional case
      // anArray[i] always means anArray + i
      anArray[i] = 0;
      //*(anArray +i) = 0;
    }
  }
}

int main() {
  int theArray[ARRAY_SIZE];
  int i;

  for (i = 0; i< ARRAY_SIZE; i++) {
    theArray[i] = i;
    printf("theArray[%d] = %d at address %p\n",
        i,theArray[i],&theArray[i]);
  }

  printf("Replacing all odd numbers in the array by 0\n");

  replaceTheOddNumbers(theArray,ARRAY_SIZE);

  for (i = 0; i< ARRAY_SIZE; i++) {
    printf("theArray[%d] = %d\n",i,theArray[i]);
  }
  return OK;
}

