#include <stdio.h>
#include <pthread.h>
#include <semaphore.h>

const size_t MAX_CNT = 10000000;
int counter;

sem_t semaphore;

void* increment(void* args) {
      
    for (size_t i = 0; i <= MAX_CNT; i++) {
        sem_wait(&semaphore);
        counter ++;
        sem_post(&semaphore);
    }

    return NULL;
}

void* decrement(void* args) {
    for (size_t j = 0; j <= MAX_CNT; j++) {
        sem_wait(&semaphore);
        counter --;
        sem_post(&semaphore);
    }

    return NULL;
} 


int main() {
    
    sem_init(&semaphore, NULL, 1); // ! - 1, DA BINÄRE SEMAPHORE!

    pthread_t threads[2];

    pthread_create(&(threads[0]), NULL, &increment, NULL);
    pthread_create(&(threads[1]), NULL, &decrement, NULL);

    pthread_join(threads[0], NULL);
    pthread_join(threads[1], NULL);

    sem_destroy(&semaphore);
    
    printf("Counter: %d \n", counter);   
}
