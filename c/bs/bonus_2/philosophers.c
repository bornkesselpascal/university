#include <stdio.h>
#include <pthread.h>
#include <semaphore.h>
#include <stdbool.h>

sem_t loeffel[4], room;
bool running = true;

void* philosopher(void* args) {
    int* number = (int *) args;
    int loeffel1 = *number;
    int loeffel2 = *(number + 1);
    int counter = 0;
    struct timespec start, stop, delta;
    double d_delta;
    
    while(running) {
        // Philosoph startet mit Nachdenken (mit 5ns gegen 0)
        nanosleep((const struct timespec[]) {{0, 5L}}, NULL);
        // nanosleep((const struct timespec[]) {{(rand() % 10), 0L}}, NULL);
        
        timespec_get(&start, TIME_UTC);
    
        // Eingeführte Fairness (Verhinderung von Verklemmung):
        // Nur 3 dürfen gleichzeitig essen
        sem_wait(&room);

        // Philosoph möchte essen    
        sem_wait(&loeffel[loeffel1]);
        sem_wait(&loeffel[loeffel2]);

        timespec_get(&stop, TIME_UTC);   

        //Philosoph isst für 2 Sekunden
        counter++;
        // printf("Philosph Nr. %d isst gerade zum %d. mal.\n", loeffel1, counter);
        nanosleep((const struct timespec[]) {{2, 0L}}, NULL);

        // Philosoph legt Löffel ab
        sem_post(&loeffel[loeffel2]);
        sem_post(&loeffel[loeffel1]);
    
        sem_post(&room);
     
        delta.tv_sec = stop.tv_sec - start.tv_sec;
        delta.tv_nsec = stop.tv_nsec - start.tv_nsec;
        d_delta = (double)delta.tv_sec + (double)delta.tv_nsec / 1000000000.0;        

        // Ausgabe der benötigten Zeit je Durchgang
        printf("ID:\t%d, DURCHGANG:\t%d, WARTEZEIT:\t%f \n\n", loeffel1, counter, d_delta);          
    }
    
    return NULL;
}

int main() {
    
    pthread_t philosophers[5];
    int numbers[4][2];

    // Zuweisung der richtigen Löffel an die Philosophen
    for(int i = 0; i < 4; i++) {
        numbers[i][0] = i;
        if (!((i + 1) > 3)) {
            numbers[i][1] = i + 1;
        }
        else {
            numbers[i][1] = 0;
        }
    }

    // Initialisierung der Semaphoren für die Löffel
    for(int i = 0; i < 4; i++) {
        if (sem_init(&loeffel[i], 0, 1) != 0) {
            printf("Fehler beim Initialisieren der Semaphore.");
            return -1;    
        }
    }

    // Initialisierung der Semaphore für den Raum
    if (sem_init(&room, 0, 3) != 0) {
        printf("Fehler beim Initialisieren der Semaphore.");
        return -1;    
    }

    // Starten der Threads mit Übergabe der Nummer des Philosophen
    for(int i = 0; i < 4; i++) {
        pthread_create(&philosophers[i], NULL, &philosopher, &numbers[i]);    
    }

    // Zeit, in der die Philosophen denken und essen
    nanosleep((const struct timespec[]) {{120, 0L}}, NULL);
    running = false;


    // Warten auf Beendigung der Threads
    for (int i = 0; i < 4; i++) {
        pthread_join(philosophers[i], NULL);
    }

    // De-Initialisierung der Semaphoren für die Löffel
    for(int i = 0; i < 4; i++) {
        if (sem_destroy(&loeffel[i]) != 0) {
            printf("Fehler beim Löschen der Semaphore.");
            return -1;    
        }
    }

    // De-Initialisierung der Semaphore für den Raum
    for(int i = 0; i < 4; i++) {
        if (sem_destroy(&room) != 0) {
            printf("Fehler beim Löschen der Semaphore.");
            return -1;    
        }
    }

    
}
