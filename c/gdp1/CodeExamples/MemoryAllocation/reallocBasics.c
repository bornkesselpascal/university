#include<stdio.h>
#include<stdlib.h>

#define OK 0
#define ERROR 1
#define SIZE_1  8 
#define SIZE_2 16

int main (void) {
  int i,k;   // Loop vars
  int *sa;   // A pointer

  // Allocate a block of SIZE_1 bytes
  // Allocate SIZE_1 int objects on the heap
  sa = malloc( SIZE_1 * sizeof(int) );
  if(sa == NULL) {
    printf("Out of memory\n");
    return ERROR; 
  }

  printf("\tMemory allocated at %p\n", sa);

  // Initialize the allocated memory
  printf("\tInitializing memory\n");
  for ( k = 0; k < SIZE_1; k++) {
    sa[k] = k * k;     // store square of k
  }

  // Print content of array
  printf("Printing integer content at at %p\n", sa);
  for ( i = 0; i < SIZE_1; i++) {
    printf("sa[%3d] = %8d at %p\n",
        i, sa[i], sa + i); 
  }

  // Enlarge array by using realloc
  sa = realloc( sa, SIZE_2 * sizeof(int) );

  if(sa == NULL) {
    printf("Out of memory\n");
    return ERROR; 
  }

  printf("\n");
  printf("Reallocated memory, now at %p\n", sa);

  // Initialize additional memory
  printf("\tInitializing additional memory\n");
  for ( k = SIZE_1; k < SIZE_2; k++) {
    sa[k] = - k * k;     // store negative square of k
  }


  // Print content of reallocated array
  printf("Printing integer content at at %p\n", sa);
  for ( i = 0; i < SIZE_2; i++) {
    printf("sa[%3d] = %8d at %p\n",
        i, sa[i], sa + i); 
  }

  // Free the memory block
  free(sa);  // Free allocated memory

  return OK;
}
