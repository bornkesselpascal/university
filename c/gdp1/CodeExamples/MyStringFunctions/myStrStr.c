// Nachbau der String-Funktionen aus string.h
// Wir spezifizieren allerdings auch das Resultat als const char*

#include <stdio.h>
#include <stdbool.h>
#include <string.h>  // zum Vergleich

#define SUCCESS 0
#define FAILURE 1

// Finde das erste Vorkommen eines Teilstrings needle in String haystack
// Falls der Teilstring vorkommt, wird der String haystack ab dieser Position
// zurueckgegeben, ansonsten NULL.
const char *my_strstr(const char *haystack, const char *needle) {
    // Falls einer der beiden Strings NULL ist, abbrechen und NULL liefern
    if (haystack == NULL || needle == NULL) { return NULL; }

    // Falls needle der leere String ist, haystack liefern!
    // Der leere String needle kommt natuerlich an ersten Stelle von haystack vor
    // Grund: forall x: x kommt ganz vorne in x+s vor.
    //        Das muss insbesondere fuer x = "" gelten
    if (*needle == '\0') { return (char *) haystack; }

    // Falls haystack der leere String ist (und needle nicht),
    // abbrechen und NULL liefern
    if (*haystack == '\0') { return NULL; }

    while (*haystack != '\0') {
        const char *haystack1; // Wegen const correctness
        const char *needle2; // Wegen const correctness

        haystack1 = haystack; // Der aktuelle Anfang von haystack
        needle2 = needle; // Der Anfang von needle

        while (*haystack1 != '\0' && *needle2 != '\0' && *haystack1 == *needle2) {
            haystack1++;
            needle2++;
        }
        if (*needle2 == '\0' ) {
            // Wir haben eine vollstaendige Uebereinstimmung gefunden
            // weil wir am Ende von needle angekommen sind
            return haystack;
        }
        // War wohl nix; also weiter mit dem naechsten Zeichen von haystack
        haystack++; 
    }
    return NULL;
}


// Test-Umgebung

struct testCase {
    const char *haystack; // haystack
    const char *needle;   // the needle to search
    const char *suffix;   // expected suffix
};


int main(void) {
    // An array of test cases
    struct testCase tcs[] = {
        {"abbxabbbxbbbaa", "bbxbb", "bbxbbbaa"},
        {"abbaabbbxbbbaa", "", "abbaabbbxbbbaa"},
        {"", "", ""},
        {"", "xyz", NULL},
        {"abbbxbbaabbbxcbxcbaa", "bbxcb", "bbxcbxcbaa"},
        {"bbbxcbxcbaa", "bbxcb", "bbxcbxcbaa"},
        {"bbxcbxcbaa", "bbxcb", "bbxcbxcbaa"},
        {"bxcbxcbaa", "bbxcb", NULL},
        {NULL, NULL, NULL},
    };

    // Run all test cases
    const char* suffix;
    bool passed;
    int tcn=0;
    while( tcs[tcn].haystack != NULL ) {
        suffix = my_strstr(tcs[tcn].haystack,tcs[tcn].needle);
        passed =
            (suffix == NULL && tcs[tcn].suffix == NULL) || 
            (
                (suffix != NULL && tcs[tcn].suffix != NULL) && 
                (strcmp(suffix,tcs[tcn].suffix) == 0)
            );

        //if(!passed) {
        if(1) {
            printf("%s testcase %d:\n"
                    "\thaystack=\"%s\"\tneedle=\"%s\"\n"
                    "\texp suffix=\"%s\"\tret suffix=\"%s\"\n",
                    passed?"PASSED":"FAILED",
                    tcn, tcs[tcn].haystack,tcs[tcn].needle,
                    tcs[tcn].suffix,suffix);
        }
        // Advance to next test
        tcn++;
    }
    return SUCCESS;
}
