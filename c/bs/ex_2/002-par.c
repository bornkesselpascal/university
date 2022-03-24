#include <stdio.h>
#include <pthread.h>
#include <string.h>
#include <stdbool.h>
#include <time.h>

#define threadnum 4
#define space 1000000

struct numspace {
    int start;
    int end;
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

    struct numspace *myspace = (struct numspace *)args;
    int myStart = myspace->start;
    int myEnd   = myspace->end;
    

    printf("Start %d; Ende %d\n", myStart, myEnd);
    
    for(int i = myStart; i < myEnd; i++){

        bool currentprime = isPrime(i);        

        if (currentprime) {
            printf("Die Zahl %d\tist eine Primzahl\n", i);
        }

    }

    return NULL;
}


int main(){

    // ZEITMESSUNG - BEGINN
    struct timespec tpstart;
    clock_gettime(CLOCK_MONOTONIC, &tpstart);
    

    struct numspace threadspace[threadnum];
    pthread_t threads[threadnum];
    int blocksize = space / threadnum;

    for (int i = 0; i < threadnum; i++){
        if (i == 0) {
            threadspace[i].start = 2;
            threadspace[i].end = threadspace[i].start + blocksize - 2;
        } else {        
            threadspace[i].start = blocksize*i;
        }

        if (i == threadnum-1) {
            threadspace[i].end = space;
        } else {
            if (i != 0) {            
                threadspace[i].end = threadspace[i].start + blocksize;
            }        
        }

        pthread_create(&threads[i], NULL, &primecheck, &threadspace[i]);
    }

    for (int j = 0; j < threadnum; j++){
        pthread_join(threads[j], NULL);
    }

    struct timespec tpend;
    clock_gettime(CLOCK_MONOTONIC, &tpend);

    time_t timedif = tpend.tv_sec - tpstart.tv_sec;
    long nanodif   = tpend.tv_nsec - tpstart.tv_nsec;

    printf("\n\nZEITMESSUNG:\nSEC:\t %ld \nNSEC:\t %ld\n\n", timedif, nanodif);

    return 0; 
}
