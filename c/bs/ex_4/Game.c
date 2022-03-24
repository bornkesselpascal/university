#include <stdio.h>
#include <pthread.h>
#include <semaphore.h>
#include <stdlib.h>
#include <stdbool.h>


sem_t player1_sem;
sem_t player2_sem;
sem_t res;

volatile int res1;
volatile int res2;
volatile bool gloabl_again;


void* sheriff(void* args) {
    
    int player1_wins;
    int player2_wins;
    int equal;

    while(player1_wins > 2 || player2_wins > 2 || equal > 9) {
        sem_wait(&player1_sem);
        sem_wait(&player2_sem);
        sem_wait(&res);


        sem_post(
    }

    return NULL;
}

void* player1(void* args) {

    bool again = true;
    while(again) {
        sem_wait(&player1_sem);
        int zahl = rand() % 4;
        res1 = zahl;
        sem_post(&player1_sem);
        sem_wait(&res);
        again = global_again;
        sem_post(&res);
    }

    return NULL;
}

void* player2(void* args) {

    bool again = true;
    while(again) {
        sem_wait(&player2_sem);
        int zahl = rand() % 4;
        res2 = zahl;
        sem_post(&player2_sem);
        sem_wait(&res);
        again = global_again;
        sem_post(&res);
    }

    return NULL;
}

int main() {

    sem_init(&player1_sem, 0, 0);
    sem_init(&player2_sem, 0, 0);

    pthread_t threads[3];
    pthread_create(&(threads[0]),NULL,&sheriff,NULL);
    pthread_create(&(threads[1]),NULL,&player1,NULL);
    pthread_create(&(threads[2]),NULL,&player2,NULL);

    for(int i = 0; i < 3; i++) {
        pthread_join(threads[i],NULL);
    }

    sem_destroy(&player1_sem);
    sem_destroy(&player2_sem);

    printf("fertig");
    return 0;
}

