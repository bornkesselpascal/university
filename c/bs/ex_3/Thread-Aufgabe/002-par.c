#include <stdio.h>
#include <pthread.h>
#include <string.h>
#include <stdbool.h>
#include <time.h>
#include <semaphore.h>

#define threadnum 4
#define space 100000

volatile int current = 2;
sem_t semaphore;


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

    int localnumer;
    while(1) {
        sem_wait(&semaphore);
        if (current < space) {        
            localnumer = current;
            current ++;
            sem_post(&semaphore);
        }
        else {
            sem_post(&semaphore);       
            return NULL;
        }

        isPrime(localnumer);
    }
}


int main(){

    sem_init(&semaphore, NULL, 1);
    pthread_t threads[threadnum];

    for (int i = 0; i < threadnum; i++){
        pthread_create(&threads[i], NULL, &primecheck, NULL);
    }

    for (int j = 0; j < threadnum; j++){
        pthread_join(threads[j], NULL);
    }
    sem_destroy(&semaphore);

    return 0; 
}
