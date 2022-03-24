#include <stdio.h>
#include <pthread.h>
#include <semaphore.h>

// Konstanten
#define NUM_THREAD 8
const int MAX_CNT = 100*1000*1000;


// Variable, die inkrementiert wird
volatile int counter = 0;


// Semaphore
sem_t semaphore;


// Thread-Funktion zur Inkrementierung der Variable 
void* increment(void* args) {
    int steps = *((int *) args);
    
    for(int i = 0; i < steps; i++) {
        // Sperren der Semaphore
        if (sem_wait(&semaphore) != 0 ) {
            printf("Fehler beim Sperren der Semaphore im Thread.");
            return NULL;
        }

        // KRITISCHER BEREICH

        // Inkrementieren der "counter"-Variable
        counter = counter + 1;

        // Freigeben der Semaphore
        if (sem_post(&semaphore) != 0 ) {
            printf("Fehler beim Freigeben der Semaphore im Thread.");
            return NULL;
        }
    }
    
    return NULL;
}


int main() {

    pthread_t threads[NUM_THREAD];
    int steps[NUM_THREAD];
    int singleStep = MAX_CNT/NUM_THREAD;
    
    // Initialisierung der Übergabeparameter zur Bestimmung der zu inkrementierenden Schritte
    for(int i = 0; i < NUM_THREAD; i++) {
        // Jeder Thread ikrementiert eine bestimmte Anzahl an Schritte        
        if (i == (NUM_THREAD-1)) {
            // Der letzte Thread inkrementiert ein n-tel des Maximalwertes und den eventuell entstehenden Rest
            int rest = MAX_CNT - (NUM_THREAD * singleStep);       
            steps[i] = singleStep + rest;
        }
        else {
            // Die ersten n-1 Treads inkrementieren ein n-tel des Maximalwertes
            steps[i] = singleStep;
        }
    }

    // Initialisierung der binären Semaphore
    if (sem_init(&semaphore, 0, 1) != 0) {
        printf("Fehler beim Initialisieren der Semaphore.");
        return -1;    
    }

    // Starten der Threads mit Übergabe der zu inkrementierenden Schritte
    for (int i = 0; i < NUM_THREAD; i++) {
        pthread_create(&threads[i], NULL, &increment, &steps[i]);
    }

    // Warten auf Beendigung der Threads
    for (int i = 0; i < NUM_THREAD; i++) {
        pthread_join(threads[i], NULL);
    }

    // Löschen der Semaphore
    if (sem_destroy(&semaphore) != 0 ) {
        printf("Fehler beim Löschen der Semaphore.");
        return -1;
    }

    // Ausgabe des Counters
    printf("\nCounter nach Inkrementieren (erwartet):\t\t%d\n", MAX_CNT);
    printf("Counter nach Inkrementieren (errechnet):\t%d\n", counter);   

    return 0;   
}
