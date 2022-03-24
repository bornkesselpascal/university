// Demonstrate the memory layout of two-dimensional arrays.
//
// In the debugger
// (gdb) break dumpArray_2dim
// (gdb) run 
// (gdb) x /12xw &main::theArray

#include <stdio.h>

#define ROWS 4
#define COLS 3
#define OK 0

void dumpArray_2dim(int anArray[][COLS], int rows, int cols) {
    int i,j;
    printf("Base address is %p\n", anArray);
    for (i=0; i<rows; i++){
        for (j=0; j<cols; j++){
            printf("at index %d,%d: address=%p content=%08x\n",
                i,j, &anArray[i][j], anArray[i][j]);
        }
    }
}

int main() {
    int theArray[ROWS][COLS]={
        {0x00000000, 0x00001111, 0x00002222 },
        {0x11110000, 0x11111111, 0x11112222 },
        {0x22220000, 0x22221111, 0x22222222 },
        {0x33330000, 0x33331111, 0x33332222 }
    };

    dumpArray_2dim(theArray, ROWS, COLS);
    return OK;
}

