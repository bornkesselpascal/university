// Nachbau der String-Funktionen aus string.h

#include <stdio.h>
#include <string.h>  // zum Vergleich

#define SUCCESS 0
#define FAILURE 1

// Konkateniere zwei Strings
char * my_strcat(char *dest, const char *src) {
    char *d = dest;
    while (*d != '\0') { d++; }
    while (1) {
        *d = *src;
        if (*src == '\0') { break; }
        d++;
        src++;
    }
    return dest;
}

// Konkateniere zwei Strings, aber hoechstens n Zeichen von src
// Achtung: der Puffer, auf den dest zeigt, braucht 
// strlen(dest) + n + 1 Bytes Platz
// Unsere Implementierung ist konform zur Standard-Implementierung von strncat()

char * my_strncat(char *dest, const char *src, size_t n) {
    char *d = dest;
    size_t i = 0;
    while (*d != '\0') { d++; }
    // d zeigt jetzt auf das '\0' des Zielpuffers
    while (i < n) {
        *d = *src;
        if (*src == '\0') { break; }
        d++;
        src++;
        i++;
    }
    *d = '\0'; // nach den hoechstens n kopierten Zeichen noch terminieren!
    return dest;
}

int main(void) {
    // Test my_strcat()
    {
        char *s1 = "efgh";
        char s2[9] = "abcd";
        char s3[ ] = "abcd";
        printf("my_strcat(\"%s\",\"%s\") = \t%s\n",
            s3,s1,my_strcat(s2,s1));
    }

    // Test my_strncat()
    {
        char *s1 = "efgh";
        char s2[9] = "abcd";
        char s3[ ] = "abcd";
        printf("my_strncat(\"%s\",\"%s\",3) = \t%s\n",
            s3,s1,my_strncat(s2,s1,3) );
    }
    return SUCCESS;
}
