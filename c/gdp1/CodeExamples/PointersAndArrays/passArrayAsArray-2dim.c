#include<stdio.h>
#include<stdlib.h>

#define MAX_Z 4
#define MAX_S 5

// Offenes Array
// Angabe von zweiter Dimension MAX_S ist Pflicht!
void drucke2(int feld[][MAX_S], int zAnz, int sAnz) {
  int i,j;

  for(i = 0; i < zAnz; i++) {
    for (j = 0; j < sAnz; j++) {
      printf("%d ",feld[i][j]);
    }
    printf("\n");
  }
  printf("\n");
  return;
}

int main(void) {
  int a[MAX_Z][MAX_S] = {
    {11,12,13,14,15},
    {21,22,23,24,25},
    {31,32,33,34,35},
    {41,42,43,44,45},
  };

  //drucke2(               a       ,MAX_Z, MAX_S); // Normale Verwendung
  //drucke2(              &a[1][1] ,2    , 3);     // Das erzeugt Warning, geht aber
  drucke2((int(*)[MAX_S]) &a[1][1] ,2    , 3);     // Mit Cast geht es ohne Warning

  return EXIT_SUCCESS;
}
