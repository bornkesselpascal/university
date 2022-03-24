// Example for a dynamically allocated 2-dimensional array of integers
// We use the storage scheme of an array of pointers that point to arrays of int

#include<stdio.h>
#include<stdlib.h>

#define ROWS 3
#define COLS 4
#define OK 0
#define ERROR 1

int main (void) {
    // Loop vars
    int row,col;

    // A pointer to an array of pointers that point to arrays of int
    int** da;

    // Allocate memory for array of pointers with ROW elements
    // Store address in base pointer da
    da = malloc(sizeof(int*) * ROWS);
    if (da == NULL) {
        printf("Out of memory\n");
        return ERROR;
    }

    // Allocate array of colums for each row and store pointers in array
    for (row = 0; row < ROWS; row++) {
        da[row] = malloc(sizeof(int) * COLS);
        if (da[row] == NULL) {
            printf("Out of memory\n");
            return ERROR;
        }
    }

    // For each row fill the 1-dimensional array of its columns
    for ( row = 0; row < ROWS; row++) {
        for (col = 0; col < COLS; col++) {
            // Note the syntax
            // It is parsed like this: (da[row])[col]
            da[row][col] = 10*(row+1) + (col+1);
        }
    }

    // Print the array
    printf("Base pointer da at %p points to %p\n",&da, da); 
    for ( row = 0; row < ROWS; row++) {
        printf("da[%d] at %p\n",row,&da[row]); 
        for (col = 0; col < COLS; col++) {
            printf("da[%d][%d] = %d at %p\n",
                    row,col,
                    da[row][col],
                    &da[row][col]); 
        }
        printf("\n");
    }

    // In the end free the allocated memory
    // For each row free the array of its columns
    for (row = 0; row < ROWS; row++) {
        free(da[row]);
    }
    // Free the array of pointers
    free(da);

    return OK;

}
