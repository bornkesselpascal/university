#include <stdio.h>
#include <pthread.h>

const size_t MAX_CNT = 10000000;
int counter;

void* increment(void* args) {
    for (size_t i = 0; i <= MAX_CNT; i++) {
        counter ++;
    }
    
    return NULL;
}

void* decrement(void* args) {
    for (size_t j = 0; j <= MAX_CNT; j++) {
        counter--;
    }

    return NULL;
} 

/*
WIR ERWARTEN, DASS DER COUNTER 0 ERGIBT, DA ER INKREMENTTIERT UND DEKREMENTIERT WURDE.
DABEI KOMMT ABER OHNE WEITERE HILFMITTEL DAS PROBLEM DER SYNCHRONISIERUNG VON 2 THREAS
ZU TAGE.
*/

int main() {
    
    pthread_t threads[2];

    pthread_create(&(threads[0]), NULL, &increment, NULL);
    pthread_create(&(threads[1]), NULL, &decrement, NULL);

    pthread_join(threads[0], NULL);
    pthread_join(threads[1], NULL);
    
    printf("Counter: %d \n", counter);   
}
