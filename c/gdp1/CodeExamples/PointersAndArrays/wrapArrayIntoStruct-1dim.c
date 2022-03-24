// We wrap an array into a structure, pass the structure by value
// and therefore pass the array per value (piggy bag).
//
// Please note the following:
// Using this 'trick' the array is not only stored once in the stack frame
// of main, it is stored three times in the stack!
// 1. In the stack frame of function main (variable theWrappedArray).
// 2. A copy of theWrappedArray for passing it to function negateElements
//    as parameter 'wrapper'. Stack frame of function negateElements.
// 3. A copy of the parameter 'wrapper', which is produced by the
//    return statement in function negateElements.
//    This copy resides in the stack frame of function main, too.
//
// Therefore, our 'trick' is a big waste of space if the array
// is of considerable size.
//

#include <stdio.h>

#define ARRAY_SIZE 10
#define OK 0

typedef struct arrayContainer {
  int len;  // number of elements stored in the array
  int array[ARRAY_SIZE];
} wrapped_array_t;

// Negate all entries of an int array
// Parameters:
// (VAL) wrapper: an array wrapped into a sturcture

wrapped_array_t negateElements(wrapped_array_t wrapper) {
  int i;

  printf("Processing %d elements of the array\n", wrapper.len);
  for(i=0; i<wrapper.len; i++) {
    printf("Inverting at index %d and address %p\n",i,&(wrapper.array[i]));
    wrapper.array[i] =  -1 * wrapper.array[i];
  }

  return wrapper;
}


int main() {
  wrapped_array_t theWrappedArray;

  theWrappedArray.len = ARRAY_SIZE;
  int i;
  for (i = 0; i< theWrappedArray.len; i++) {
    theWrappedArray.array[i] = i;
    printf("theWrappedArray.array[%d] = %d at address %p\n",
        i,theWrappedArray.array[i],&(theWrappedArray.array[i]));
  }

  theWrappedArray = negateElements(theWrappedArray);

  for (i = 0; i< theWrappedArray.len; i++) {
    printf("theWrappedArray.array[%d] = %d at address %p\n",
        i,theWrappedArray.array[i],&(theWrappedArray.array[i]));
  }

  return OK;
}

