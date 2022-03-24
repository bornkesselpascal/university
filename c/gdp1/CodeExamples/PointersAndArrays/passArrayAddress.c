// Demonstrate that arrays are always passed by reference
// Arrays are really something special
// See last call to printTheArgumentsAddress
#include <stdio.h>

#define ARRAY_SIZE 10
#define OK 0

void printTheArgumentsAddress(int anArray[]) {
    printf("Array address is %p\n", anArray);
}

int main() {
    int theArray[ARRAY_SIZE];

    printTheArgumentsAddress(theArray);
    printTheArgumentsAddress(&theArray[0]);

    //printTheArgumentsAddress(&theArray);
    // Results in compiler warning!
    //
    // passArrayAddress.c:19:5: warning: passing argument 1 of
    // 'printTheArgumentsAddress' from in compatible pointer type
    // passArrayAddress.c:9:6: note: expected 'int *' but argument
    // is of type 'int (*)[10]'
    //
    // Reason: there is no storage object of type int* with name theArray.
    // Such a pointer object does not exist.
    // The compiler corrects our fault and passes again the base address
    // of the array
    // => do not use the last call scheme &theArray because it is wrong! 

    return OK;
}

