// Demonstrate that arrays are always passed by reference
//

#include <stdio.h>

#define ARRAY_SIZE 10
#define OK 0

// Negate all entries of an int array
// Parameters:
// (REF) anArray: the array to be processed as open array
// (VAL)   asize: the size of the array
void negateElements(int anArray[], int asize) {
  int i;

  printf("Processing %d elements of the array\n", asize);
  for(i=0; i<asize; i++) {
    printf("Inverting at index %d and address %p\n",i,&anArray[i]);
    anArray[i] =  -1 * anArray[i];
  }
}


int main() {
  int theArray[ARRAY_SIZE];
  int i;

  for (i = 0; i< ARRAY_SIZE; i++) {
    theArray[i] = i;
    printf("theArray[%d] = %d at address %p\n",i,theArray[i],&theArray[i]);
  }

  negateElements(theArray,ARRAY_SIZE);

  //negateElements(&theArray[4],ARRAY_SIZE-4); // Pass array with offset

  //negateElements(&theArray[4],3);          // Pass array with offset
  // Only process 3 elements

  for (i = 0; i< ARRAY_SIZE; i++) {
    printf("theArray[%d] = %d\n",i,theArray[i]);
  }
  return OK;
}

