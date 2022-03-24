#include <stdio.h>
#include <pthread.h>
#include <stdatomic.h>

// Konstanten
#define NUM_THREAD 4
const int MAX_CNT = 100*1000*1000;


// Variable, die inkrementiert wird
volatile int counter = 0;


// Thread-Funktion zur Inkrementierung der Variable 
void* increment(void* args) {
    int steps = *((int *) args);
    
    for(int i = 0; i < steps; i++) {

        // KRITISCHER BEREICH

        // Inkrementieren der "counter"-Variable durch eine atomare Operation
        atomic_fetch_add(&counter, 1);
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

    // Starten der Threads mit Übergabe der zu inkrementierenden Schritte
    for (int i = 0; i < NUM_THREAD; i++) {
        pthread_create(&threads[i], NULL, &increment, &steps[i]);
    }

    // Warten auf Beendigung der Threads
    for (int i = 0; i < NUM_THREAD; i++) {
        pthread_join(threads[i], NULL);
    }

    // Ausgabe des Counters
    printf("\nCounter nach Inkrementieren (erwartet):\t\t%d\n", MAX_CNT);
    printf("Counter nach Inkrementieren (errechnet):\t%d\n", counter);   

    return 0;   
}
