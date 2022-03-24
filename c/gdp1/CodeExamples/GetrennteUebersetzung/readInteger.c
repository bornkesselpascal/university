#include <stdio.h>
#include <stdbool.h>

#define ERROR 1
#define OK 0
#define MAXVERSUCH 3

// Externe Variablen
extern bool debug;

// Funktionen
int readInteger(char* prompt, int* n) {

    bool erfolg = false;
    int versuch = 1;    // Anzahl der Versuche

    while (!erfolg && versuch <= MAXVERSUCH ) {
        printf("%s",prompt);
        fflush(stdout);

        if(scanf("%d", n) != 1) {
            versuch++;
            printf("Sie muessen hier eine Zahl eingeben!!!\n");
            while(getchar() != '\n');
            continue;
        } else {
            erfolg = true;
            while(getchar() != '\n');
        }
    }

    // Stelle fest, wieso wir Schleife verlassen haben
    if (!erfolg) {
        if(debug) {
            fprintf(stderr,"Fehler bei der Eingabe einer Zahl\n");
        }
        return ERROR;
    } else {
        if(debug) {
            fprintf(stderr,"Erfolg beim Versuch Nr %d\n", versuch);
        }
        return OK;
    }
}
