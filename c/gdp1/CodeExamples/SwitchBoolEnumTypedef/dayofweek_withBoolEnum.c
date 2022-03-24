// Einlesen einer Zahl und Interpretation als Wochentag
// Variante mit switch, bool und enum

#include <stdio.h>
#include <stdbool.h>

enum ResCodes {
    OK,
    ERROR
};

enum WeekDay {
    MO=1,
    DI,
    MI,
    DO,
    FR,
    SA,
    SO,
};

enum ResCodes readInteger(char* prompt, int* n) {
    bool erfolg = false;
    int zaehler = 2;    // Anzahl der Versuche

    while (!erfolg && zaehler > 0) {
        printf("%s",prompt);
        fflush(stdout);

        if(scanf("%d", n) != 1) {
            zaehler--;
            printf("Sie muessen hier eine Zahl eingeben!!!\n");
        } else {
            erfolg = true;
        }
        while(getchar() != '\n');
    }

    // Stelle fest, wieso wir Schleife verlassen haben
    if (!erfolg) {
        return ERROR;
    } else {
        return OK;
    }
}


int main (void) {
    enum WeekDay wd;
    // Wochentag einlesen
    printf("Bitte geben Sie die Nummer des Wochentags ein:\n");
    printf("%-10s-> %1d\n","Montag",1);
    printf("%-10s-> %1d\n","Dienstag",2);
    printf("%-10s-> %1d\n","Mittwoch",3);
    printf("%-10s-> %1d\n","Donnerstag",4);
    printf("%-10s-> %1d\n","Freitag",5);
    printf("%-10s-> %1d\n","Samstag",6);
    printf("%-10s-> %1d\n","Sonntag",7);

    if(readInteger("Nummer des Wochentags = ", (int*) &wd) != OK ) {
        printf("Fehler bei der Eingabe des Wochentags\n");
        return ERROR;
    }

    // Vorteil von enum WeekDay:
    // Compiler warnt, wenn nicht alle Faelle in switch abgedeckt werden
    // Test: Fall SO und default auskommentieren
    switch(wd) {
        case MO:
        case DI:
        case MI:
        case DO:
        case FR:
            printf("\nSie haben einen Werktag gewaehlt\n");
            break;
        case SA:
            printf("\nSie haben den Samstag gewaehlt\n\n");
            printf("Das ist ein Werktag, an dem aber in fast allen"
                " Bundeslaendern schulfrei ist\n");
            break;
        case SO:
            printf("\nSie haben den Sonntag gewaehlt\n\n");
            printf("An diesem Tag habe die meisten Arbeitnehmer frei\n");
            break;
        default:
            printf("\nEinen Wochentag mit dieser Nummer gibt es nicht\n");
    }

    return OK;
}
