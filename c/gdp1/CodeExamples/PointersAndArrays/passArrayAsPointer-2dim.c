#include<stdio.h>

#define MAX_Z 3
#define MAX_S 4
#define SUCCESS 0
#define FAILURE 1

// Uebergabe eines einfachen Pointers int* pfeld
// Zugriff ueber Pointer-Arithmetik relativ zu Pointer auf Anfang des Arrays
// Achtung: damit ist Zugriffssyntax pfeld[i][j] nicht mehr moeglich!!!
//
void drucke4(int* pfeld, int zAnz, int sAnz) {
  int i,j;

  for(i = 0; i < zAnz; i++) {
    for (j = 0; j < sAnz; j++) {
      // printf("%d ", pfeld[i][j] );
      // error: subscripted value is neither array nor pointer
      printf("%d ", *(pfeld + (i * sAnz) + j) );
    }
    printf("\n");
  }
  printf("\n");
  return;
}

int main(void) {
  int a[MAX_Z][MAX_S] = {
    {1,2,3,2},
    {4,2,3,2},
    {1,2,3,2}
  };

  int *pint;
  void *pvoid;

  // Trick:
  // Speichere Basisadresse des zweidimensionalen Arrays ueber
  // Umweg via void-Pointer pvoid in den int-Pointer pint
  // Damit geht die Typinformation des 2-dim Arrays verloren und
  // neue wird eingefuehrt.
  pvoid = a;
  pint = pvoid;
  // Das koennte man auch so schreiben, mit eine Type-Cast
  // erntet aber dafür eine Warnung durch den Compiler
  // pint = (int)a;

  // Uebergebe int Pointer pint
  drucke4(pint,MAX_Z,MAX_S);

  return SUCCESS;
}
