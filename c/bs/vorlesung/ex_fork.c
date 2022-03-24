#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>

int main(void) {
    int i;
    int sum = 0;
    for(i=0; i<3; i++) {
        fork();
        sum += i;
    }
    printf("%d\n\n", sum);
    return 0;
}
