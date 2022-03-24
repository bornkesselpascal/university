// Nachbau der String-Funktionen aus string.h
// Die hier implementierte Funktion strncpy ist nicht ganz konform zum Standard.

#include <stdio.h>
#include <string.h>  // zum Vergleich

#define SUCCESS 0
#define FAILURE 1

// Kopiere durch \0 terminierte Zeichenkette von src nach dest.
// Der Puffer, auf den dest zeigt, muss gross genug sein, um
// den durch src bezeichneten String aufnehmen zu koennen.
char * my_strcpy(char *dest, const char *src) {
    char *d = dest;

    while (*src != '\0') {
        *d = *src;
        d++;
        src++;
    }

    // Terminierung mit '\0'
    *d = '\0';

    return dest;
}

// Kopiere String von src nach dest, aber hoechstens n Zeichen von src.
// Achtung: die folgende Implementierung ist nicht ganz konform zum Standard!
// Unsere Version ist sicherer als die Version des Standards :-)
//
// man strncpy (Standard)
// ...
// The  strncpy()  function  is  similar, except that at most n bytes
// of src are copied.  Warning: If there is no null byte among the first n bytes
// of src, the string placed in dest will not be null terminated.
// If the length of src is less than n, strncpy() pads the remainder of dest
// with null bytes.
// ...

// Wir terminieren garantiert den String nach den hoechstens n kopierten
// Zeichen.
// Fuer das abschliessende '\0' brauchen wir ein zusaetzliches Byte Platz
// im Puffer

char * my_strncpy(char *dest, const char *src, size_t n) {
    char *d = dest;
    size_t i;

    i = 0;
    while (i < n && *src != '\0') {
        *d = *src;
        d++; src++; i++;
    }

    // Terminierung und Padding mit '\0'
    while (i < n + 1) {
        // falls src n byte != '\0' enthaelt, dann haengen wir
        // genau ein zusaetzliches '\0' hinten dran
        *d = '\0';
        d++; i++;
    }

    return dest;
}

int main(void) {
    // Test my_strcpy()
    {
        char *s1 = "abcd";
        char s2[5];
        printf("my_strcpy(s2,\"%s\") = %s\tStandard liefert:%s\n",
            s1,my_strcpy(s2,s1), strcpy(s2,s1));
    }

    // Test my_strncpy()
    #define SIZE 8
    {
        char s[SIZE] = "abcdef";
        char mycpy[SIZE]="ABCDEFG";
        char stdcpy[SIZE]="ABCDEFG";
        int  n = 4;

        my_strncpy(mycpy ,s,n);
           strncpy(stdcpy,s,n);

        printf("\n");
        printf("my_strncpy versus strncpy\n");
        printf("\n");
        printf("Zeichenweiser Vergleich:\n");
        printf("Index         orig        my_strcpy        standard\n");
        int i;
        for (i = 0; i < SIZE; i++) {
            printf("%d\t%8x %2c\t%8x %2c\t%8x %2c\n",
                       i,
                     s[i],     s[i]>=32?s[i]:'.',
                 mycpy[i], mycpy[i]>=32?mycpy[i]:'.',
                stdcpy[i],stdcpy[i]>=32?stdcpy[i]:'.');
        }

        printf("\n");
        printf("my_strncpy(mycpy,\"%s\",%d) liefert %s\tStandard liefert:%s\n",
            s,n,my_strncpy(mycpy,s,n), strncpy(stdcpy,s,n));
    }

    return SUCCESS;
}
