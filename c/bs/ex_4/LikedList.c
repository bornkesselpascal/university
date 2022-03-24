#include <stdio.h>
#include <pthread.h>
#include <semaphore.h>
#include <stdlib.h>
#include <stdbool.h>


sem_t lst_semaphore;


// Struktur eines Listenelements
struct lst {
    int payload;
    struct lst* next;
};

// Kopf der Liste
struct lst* root = NULL;

// Hinzufügen am Anfang einer Liste
int addLL(int in) {
    sem_wait(&lst_semaphore);    
    struct lst* new = malloc(sizeof (struct lst));
    if (new == NULL) {
        return -1;
    }
    
    new->payload = in;
    new->next = root;
    root = new;
    sem_post(&lst_semaphore);
    return 0;
}

// Entfernen vom Ende einer Liste
int removeLL(int *out) {
    sem_wait(&lst_semaphore);    
    struct lst* last = root;        // Element, dass gelöscht wird
    struct lst* newLast = last;     // neues letztes Element

    // Sonderfall: kein Element
    if(root == NULL) {
        sem_post(&lst_semaphore);        
        return -1;
    }

    // Sonderfall: ein Element
    if(root->next == NULL) {
        *out = root->payload;
        root = NULL;
        free(last);
        sem_post(&lst_semaphore); 
        return 0;
    }

    while(last != NULL && last->next != NULL) {
        newLast = last;
        last = last->next;
    }

    // Am Ende der Schleife zeigt last auf das letzte Element.

    newLast->next = NULL;
    *out = last->payload;
    free(last);

    sem_post(&lst_semaphore); 
    return 0;
}

// Länge der Liste
int lenghtLL() {
    sem_wait(&lst_semaphore);     
    if(root == NULL) {
        sem_post(&lst_semaphore);         
        return 0;
    }

    if(root->next == NULL) {
        sem_post(&lst_semaphore);         
        return 1;
    }


    int lenght = 0;
    struct lst* tmp;
    
    while(tmp->next == NULL) {
        lenght++;
        tmp = tmp->next;
    }
    sem_post(&lst_semaphore); 
    return lenght;
}

// Löschen der Liste
int cleanLL() {
    int i = 0;    
    while(removeLL(&i) == 0) {
        // DO NOTHING    
    }
}

bool isPrime(int number){
    int j = 0;

    for (j=2;j<number;j++) {
    
        if(number % j == 0) {
            return false;
        }
    }

    return true;
}


void* producer(void* args) {
    
    int counter = 0;
    while(counter < 100) {
        addLL((counter*100));
        isPrime(counter);
        counter++;
    }  

    return NULL;
}

void* consumer(void* args) {

    int counter = 0;
    int value;
    while(counter < 100) {
        removeLL(&value);
        isPrime(counter);
        counter++;
    }

    return NULL;
}


int main() {

    sem_init(&lst_semaphore, 0, 1);

    pthread_t threads[6];
    pthread_create(&(threads[0]),NULL,&producer,NULL);
    pthread_create(&(threads[1]),NULL,&producer,NULL);
    pthread_create(&(threads[2]),NULL,&producer,NULL);
    pthread_create(&(threads[3]),NULL,&consumer,NULL);
    pthread_create(&(threads[4]),NULL,&consumer,NULL);
    pthread_create(&(threads[5]),NULL,&consumer,NULL);

    for(int i = 0; i < 6; i++) {
        pthread_join(threads[i],NULL);
    }

    sem_destroy(&lst_semaphore);

    printf("fertig");
    return 0;
}

