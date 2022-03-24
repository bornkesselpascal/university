#include <stdio.h>

#define OK 0
#define ROWS 3
#define COLS 5

// -----------------------------------------
// Declarations
// -----------------------------------------

// Declare a 2-dimensional array
// Either use an incomplete type (open array) or use storage
// class 'extern'.

// int alpha[][COLS];
// Line above just declares the array by using an incomplete type

extern int alpha[ROWS][COLS];
// Line above declares the array by using classifier 'extern'

// Forward declaration of functions
// Note: functions allways get storage class 'extern'
extern void operateOnGlobalArray();
void printGlobalArray();

// -----------------------------------------
// MAIN
// -----------------------------------------
int main(void) {
  // Use the functions declared above
  operateOnGlobalArray();
  printGlobalArray();
  return OK;
}

// -----------------------------------------
// Function definitions
// -----------------------------------------

void operateOnGlobalArray() {
  int i,j;
  for (i=0;i<ROWS;i++){
    for(j=0; j<COLS; j++) {
      // Use the global array declared above
      alpha[i][j] = i+j;
    }
  }
}

void printGlobalArray() {
  int i,j;
  for (i=0;i<ROWS;i++){
    for(j=0; j<COLS; j++) {
      // Use the global array declared above
      printf("alpha[%d][%d]=%d\t", i,j,alpha[i][j]);
    }
    printf("\n");
  }
}

// -----------------------------------------
// Definition of global variables
// -----------------------------------------

// Definition of the array
// Since the array is global it is initialized
// with 0 elements
int alpha[ROWS][COLS];
