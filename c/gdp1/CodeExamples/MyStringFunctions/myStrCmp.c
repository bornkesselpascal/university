// Nachbau der String-Funktionen aus string.h

#include <stdio.h>
#include <string.h>  // zum Vergleich

#define SUCCESS 0
#define FAILURE 1

// Vergleiche zwei Strings
int my_strcmp( const char *s1, const char *s2) {
    int diff=0;
    while ( (diff = (*s1) - (*s2) ) == 0 && (*s1) != '\0' && (*s2) != '\0') {
        s1++;
        s2++;
    }
    return diff;
}

// Vergleiche zwei Strings, aber hoechsten n Zeichen
int my_strncmp( const char *s1, const char *s2, size_t n) {
    int diff=0;
    size_t i = 0;
    while (i < n && (diff=(*s1)-(*s2) ) == 0 && (*s1) != '\0' && (*s2) != '\0'){
        s1++;
        s2++;
        i++;
    }
    return diff;
}

int main(void) {
    // Test my_strcmp()
    {
        char *s1 = "abcd";
        char *s2 = "abce";
        char *s3 = "abcc";
        char *s4 = "abc";
        char *s5 = "abcde";
        printf("my_strcmp(\"%s\",\"%s\") = %d\tStandard liefert:%d\n",
            s1,s1,my_strcmp(s1,s1), strcmp(s1,s1) );
        printf("my_strcmp(\"%s\",\"%s\") = %d\tStandard liefert:%d\n",
            s1,s2,my_strcmp(s1,s2), strcmp(s1,s2) );
        printf("my_strcmp(\"%s\",\"%s\") = %d\tStandard liefert:%d\n",
            s1,s3,my_strcmp(s1,s3), strcmp(s1,s3) );
        printf("my_strcmp(\"%s\",\"%s\") = %d\tStandard liefert:%d\n",
            s1,s4,my_strcmp(s1,s4), strcmp(s1,s4) );
        printf("my_strcmp(\"%s\",\"%s\") = %d\tStandard liefert:%d\n",
            s1,s5,my_strcmp(s1,s5), strcmp(s1,s5) );
    }

    // Test my_strncmp()
    {
        char *s1 = "abcd";
        char *s2 = "abcef";
        char *s3 = "abccf";
        char *s4 = "abc";
        char *s5 = "abcdeg";
        printf("my_strncmp(\"%s\",\"%s\",3) = %d\tStandard liefert:%d\n",
            s1,s2,my_strncmp(s1,s2,3), strncmp(s1,s2,3) );
        printf("my_strncmp(\"%s\",\"%s\",4) = %d\tStandard liefert:%d\n",
            s1,s2,my_strncmp(s1,s2,4), strncmp(s1,s2,4) );
        printf("my_strncmp(\"%s\",\"%s\",4) = %d\tStandard liefert:%d\n",
            s1,s3,my_strncmp(s1,s3,4), strncmp(s1,s3,4) );
        printf("my_strncmp(\"%s\",\"%s\",4) = %d\tStandard liefert:%d\n",
            s1,s4,my_strncmp(s1,s4,4), strncmp(s1,s4,4) );
        printf("my_strncmp(\"%s\",\"%s\",3) = %d\tStandard liefert:%d\n",
            s1,s5,my_strncmp(s1,s5,5), strncmp(s1,s5,5) );
    }
    return SUCCESS;
}
