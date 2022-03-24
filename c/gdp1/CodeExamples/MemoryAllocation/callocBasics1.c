// Show hat malloc just allocates memory and does not initialize
// This bears the risk of getting old data during subsequent allocations
// Motivate use of calloc
#include<stdio.h>
#include<stdlib.h>

#define OK 0
#define ERROR 1
#define SIZE 16

int main (void) {
  int i,k;   // Loop vars
  int *sa;   // A pointer

  // Allocate a block of SIZE bytes for 10 times and free again
  for (i = 0; i < 10; i++) {
    printf("Iteration %d:\n", i);

    // Allocate SIZE int objects on the heap
    sa = malloc( SIZE * sizeof(int) );
    if(sa == NULL) {
      printf("Out of memory\n");
      return ERROR; 
    }

    printf("\tMemory allocated at %p\n", sa);

    // Initialize the allocated memory in the first run of the loop
    if (i == 0) {
      printf("\tInitializing memory\n");
      for ( k = 0; k < SIZE; k++) {
        // Note the syntax used to access the arrays
        sa[k] = k * k;     // store square of k
      }
    } else {
      printf("\tNot initializing memory\n");
    }

    // free the memory block
    printf("\tFreeing memory at %p\n",sa);
    free(sa);  // Free allocated memory
  }

  // Allocate memory again
  // Allocate SIZE int objects on the heap
  sa = malloc( SIZE * sizeof(int) );

  if(sa == NULL) {
    printf("Out of memory\n");
    return ERROR; 
  }

  printf("\n");
  printf("Memory allocated once more at %p\n", sa);

  // Print content of uninitialized memory
  printf("Printing integer content at at %p\n", sa);
  for ( i = 0; i < SIZE; i++) {
    printf("sa[%3d] = %8d at %p\n",
        i, sa[i], sa + i); 
  }

  // Free the memory block
  free(sa);  // Free allocated memory

  return OK;
}
