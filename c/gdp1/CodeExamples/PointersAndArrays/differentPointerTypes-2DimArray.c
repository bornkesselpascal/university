#include <stdio.h>

int main() {
  // Ein zweidimensionales Array
  int theArray[3][4]= {
    {100,101,102,103},
    {104,105,106,107},
    {108,109,110,111},    // man beachte das ','
  };

  // Nomaler Zugriff
  int i,j;
  for (i = 0; i< 3; i++) {
    for (j = 0; j< 4; j++) {
      printf("theArray[%d][%d]=%d\n",i,j,theArray[i][j]);
    }
    printf("\n");
  }

  /*
     Ueber den Umweg eines void-Pointers definieren wir einen neuen
     Pointer auf ein eindimensionales Array ap, der auf die Basis-Adresse
     des zweidimensionalen Arrays zeigt.
     Danach greifen wir in der Schleife auf das zweidimensionale Array
     wie auf ein eindimensionales Array zu.
     --> Im Speicher liegen die Elemente des zweidimenisonalen Arrays
     dicht, Zeile fuer Zeile
     */

  void *vp = theArray;
  int *ap = vp;

  for (i=0; i<12; i++) {
    printf("ap[%2d]=%d und ebenso *(ap+%2d)=%d\n",
        i, ap[i],i, *(ap+i));    
  }

  return 0;
}

