// Example for memory allocation of variables with primitive type 
// Hint: execute program for several times
// Observation:
// - address of variable on stack does not change
// - address of variable on heap changes each time

#include<stdio.h>
#include<stdlib.h>

#define OK 0
#define ERROR 1

int main (void) {
    int a = 3;    // An integer variable allocated on the stack
    int *pi;      // A pointer

    pi = malloc(sizeof(int) ); // Allocate memory on the heap

    if(pi == NULL) {
        printf("Out of memory\n");
        return ERROR; 
    }

    // We got some memory, now use it
    *pi = a;

    printf("Variable   a at %p stores %d\n",&a,  a);
    printf("Variable *pi at %p stores %d\n",pi,*pi);

    free(pi);  // Free allocated memory

    return OK;
}
