// Nachbau der String-Funktionen aus string.h

#include <stdio.h>
#include <string.h>  // zum Vergleich

#define SUCCESS 0
#define FAILURE 1

// Berechne die Laenge der Strings
size_t my_strlen(const char * s) {
    size_t len = 0;
    while (*s != '\0') {
        s++;
        len++;
    }
    return len;
}


int main(void) {
    // Test my_strlen()
    {
        char *s1 = "1234567";
        char *s2 = "";
        printf("my_strlen(\"%s\") = %d\tStandard liefert:%d\n",
            s1, (int) my_strlen(s1), (int) strlen(s1));
        printf("my_strlen(\"%s\") = %d\tStandard liefert:%d\n",
            s2, (int) my_strlen(s2), (int) strlen(s2));
    }

    return SUCCESS;
}
