#include<stdio.h>
#include<stdlib.h>

#define OK 0
#define ERROR 1
#define SIZE_1 32
#define SIZE_2 16

int main (void) {
  int i,k;   // Loop vars
  int *sa1;   // A pointer
  int *sa2;   // A pointer

  // Allocate a block of SIZE_1 bytes
  // Allocate SIZE_1 int objects on the heap
  sa1 = malloc( SIZE_1 * sizeof(int) );
  if(sa1 == NULL) {
    printf("Out of memory\n");
    return ERROR; 
  }

  printf("\tMemory allocated at %p\n", sa1);

  // Initialize the allocated memory
  printf("\tInitializing memory\n");
  for ( k = 0; k < SIZE_1; k++) {
    sa1[k] = k * k;     // store square of k
  }

  // Print content of array
  printf("Printing integer content at %p\n", sa1);
  for ( i = 0; i < SIZE_1; i++) {
    printf("sa1[%3d] = %8d at %p\n",
        i, sa1[i], sa1 + i); 
  }

  // Schrink array by using realloc
  sa1 = realloc( sa1, SIZE_2 * sizeof(int) );

  if(sa1 == NULL) {
    printf("Out of memory\n");
    return ERROR; 
  }

  printf("\n");
  printf("Reallocated memory for sa1, now at %p\n", sa1);

  // Allocate memory for sa2
  sa2 = malloc( SIZE_2 * sizeof(int) );

  if(sa2 == NULL) {
    printf("Out of memory\n");
    return ERROR; 
  }

  printf("\n");
  printf("Allocated memory for sa2 at %p\n", sa2);


  // Print content of arrays
  printf("Printing content of sa2 at %p\n", sa2);
  for ( i = 0; i < SIZE_2; i++) {
    printf("sa2[%3d] = %8d at %p\n",
        i, sa2[i], sa2 + i); 
  }
  printf("Printing content of sa1 at %p\n", sa1);
  for ( i = 0; i < SIZE_2; i++) {
    printf("sa1[%3d] = %8d at %p\n",
        i, sa1[i], sa1 + i); 
  }


  // Free the memory block
  free(sa1);  // Free allocated memory
  free(sa2);  // Free allocated memory

  return OK;
}
