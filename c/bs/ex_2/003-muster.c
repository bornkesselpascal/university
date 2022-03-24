#include <stdio.h>
#include <pthread.h>
#include <string.h>
#include <stdbool.h>
#include <time.h>

#define threadnum 25
#define space 100000

struct parameter {
    int offset;
    int step;
    int group;
};


bool isPrime(int number){
    int j = 0;

    for (j=2;j<number;j++) {
    
        if(number % j == 0) {
            return false;
        }
    }

    return true;
}


void *primecheck(void * args){

    struct parameter *param = (struct parameter *)args;
   
    for(int i = 2+param->offset; i < space; i+=param->step){

        for(int j=0; j < param->group; j++) {
            isPrime(i+j);
        }

    }

    return NULL;
}


int main(){

    pthread_t threads[threadnum];
    struct parameter param[threadnum];

    for(int counter = 0; counter < threadnum; counter++) {
        param[counter].group = 2;
        param[counter].offset = counter * param[counter].group;
        param[counter].step = 4 * param[counter].group;

        pthread_create(&threads[counter], NULL, &primecheck, &param[counter]);
    }

    
    for (int j = 0; j < threadnum; j++){
        pthread_join(threads[j], NULL);
    }


    return 0; 
}
