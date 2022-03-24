#include<stdio.h>
#include<string.h>

#define MAX 15
#define SUCCESS 0
#define FAILURE 1

// Zugriff ueber Pointer-Arithmetik relativ zu Pointer auf Anfang des Arrays
void drucke3(char *str, int anz) {
  int i;
  printf("drucke3:\n");
  //for(i = 0; i < anz ; i++) {
  for(i = 0; i < anz && *(str+i) != '\0'; i++) {
    printf("%d:%c\n",i,*(str+i));
  }
  return;
}

// Zugriff ueber Pointer unter Ausnutzung von '\0'-Terminierung
// Pointer wird selbst als Laufvariable benutzt!
void drucke4(char *str) {
  int i = 0;
  printf("drucke4:\n");
  while (*str != '\0') {
    printf("%d:%c\n",i,*str);
    str++; i++;
  }
  return;
}

// String als char* und drucken ueber Format %s
// Die Terminierung mit '\0' wird ausgenuetzt in printf
void drucke5(char *str) {
  printf("drucke5:\n");
  printf("%s\n",str);
  return;
}

int main(void) {
  char s[MAX] = "Ein String";

  // #include <string.h>
  // size_t strlen(const char *s);
  // Berechnet Laenge der Zeichenkette ohne '\0'
  drucke3(s,strlen(s));

  drucke4(s);
  drucke5(s);

  return SUCCESS;
}
