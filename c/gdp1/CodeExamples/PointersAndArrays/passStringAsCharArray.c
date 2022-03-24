#include<stdio.h>
#include<string.h>

#define MAX 15
#define SUCCESS 0
#define FAILURE 1

// String als Array mit expliziten Grenzen und drucken ueber %c
// Die Angabe der Grenze MAX im Typ des Arrays wird vom Compiler ignoriert.
// Also besser gleich weglassen (siehe drucke2) und offenes Array nutzen.
void drucke1(char str[MAX],int anz) {
  int i;
  printf("drucke1:\n");
  //for(i = 0; i < anz; i++) {
  for(i = 0; i < anz && str[i] != '\0'; i++) {
    printf("%d:%c\n",i,str[i]);
  }
  return;
}


// String als offenes Array und drucken ueber %c
void drucke2(char str[], int anz) {
  int i;
  printf("drucke2:\n");
  //for(i = 0; i < anz; i++) {
  for(i = 0; i < anz && str[i] != '\0'; i++) {
    printf("%d:%c\n",i,str[i]);
  }
  return;
}

int main(void) {
  char s[MAX] = "Ein String";

  // #include <string.h>
  // size_t strlen(const char *s);
  // Berechnet Laenge der Zeichenkette ohne '\0'

  drucke1(s,strlen(s));

  // Aufruf drucke1(s,MAX) ebenfalls moeglich

  drucke1(s,MAX);

  // Dann muss aber drucke1() auf '\0' pruefen oder man
  // riskiert die Ausgabe von Muell-Zeichen nach dem '\0'
  // In beiden Faellen kommt es aber nicht zur Verletzung von
  // Array-Grenzen, da MAX die korrekte Grenze ist.

  drucke2(s,strlen(s));

  return SUCCESS;
}
