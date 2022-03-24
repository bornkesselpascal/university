// Example for a dynamically allocated 1-dimensional array
// of double objects

#include<stdio.h>
#include<stdlib.h>

#define SIZE 5
#define OK 0
#define ERROR 1

int main (void) {
  // Loop var
  int i;

  // A pointer to an array of double
  double* sa;

  // Allocate memory for array double
  // Store address in base pointer sa
  sa = malloc(sizeof(double) * SIZE);
  if (sa == NULL) {
    printf("Out of memory\n");
    return ERROR;
  }

  // Fill the 1-dimensional array
  for ( i = 0; i < SIZE; i++) {
    // Note the syntax used to access the arrays
    sa[i] = i + i * 0.1;     // store 0.0, 1.1 and so forth
  }

  // Print the array
  printf("Base pointer sa at %p points to %p\n",&sa, sa); 
  for ( i = 0; i < SIZE; i++) {
    printf("sa[%d] = %4.1f at %p\n",
        i, sa[i], &sa[i]); 
  }

  // In the end free the allocated memory
  // Free the array by using the address we got from malloc
  // Never use other adresses!
  free(sa);

  return OK;
}
