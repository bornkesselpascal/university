// Nachbau der String-Funktionen aus string.h
// char *strdup(const char *s);

#include <stdio.h>
#include <stdlib.h>
#include <string.h>  // zum Vergleich

#define SUCCESS 0
#define FAILURE 1

// Dupliziere String, alloziere auf Heap mittels malloc
char *my_strdup(const char *src){
    char* clone;
    // Achtung: 1 Byte mehr fuer Terminierung allozieren
    clone = malloc( (strlen(src)+1) * sizeof(char));
    if (clone == NULL) {
        return NULL;
    }

    // Jetzt kopieren wir
    char* d = clone;
    while (*src != '\0') {
        *d = *src;
        d++;
        src++;
    }
    // Terminierung mit '\0'
    *d = '\0';

    return clone;
}

int main(void) {
    // Test my_strdup()
    char* s1 = "1234567";
    char* s2 = "";
    char* stdclone;
    char* myclone;

    // Klone s1
    myclone = my_strdup(s1);
    stdclone = strdup(s1);

    printf("my_clone(\"%s\") = \"%s\"\tStandard liefert:\"%s\"\n",
            s1, myclone, stdclone);

    // Speicher freigeben!!
    free(myclone);
    free(stdclone);

    // Klone s2
    myclone = my_strdup(s2);
    stdclone = strdup(s2);

    printf("my_clone(\"%s\") = \"%s\"\tStandard liefert:\"%s\"\n",
            s2, myclone, stdclone);
    // Speicher freigeben!!
    free(myclone);
    free(stdclone);

    return SUCCESS;
}
