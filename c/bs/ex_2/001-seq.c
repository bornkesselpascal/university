#include <stdio.h>
#include <pthread.h>
#include <string.h>
#include <stdbool.h>

#define threadnum 0
#define space 100000

bool isPrime(int number){
    int j = 0;

    for (j=2;j<number;j++) {
    
        if(number % j == 0) {
            return false;
        }
    }

    return true;
}

int main() {

    int i = 0;
    bool prime = false;

    for (i=2; i<(space+1);i++) {
        prime = isPrime(i);

        if (prime) {
            printf("Die Zahl %d\tist eine Primzahl\n",i);
        }         
    }

}


