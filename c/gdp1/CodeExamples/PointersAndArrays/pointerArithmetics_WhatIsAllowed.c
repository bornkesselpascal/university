#include<stdio.h>
#include<stdbool.h>

int main (void)  {
  int d;
  bool res;
  int a[5] = {0,1,2,3,4};
  int *pi1, *pi2;
  void *pv1, *pv2;


  pi1 = &a[1];        // alternativ:  a + 1
  pi2 = &a[4];        // alternativ:  a + 4

  // -----------------------------------------------------------
  // Erlaubt:
  d = pi2 - pi1;      // Differenz der beiden int*

  // Vergleiche zwischen Pointern gleichen Typs
  res = (pi1 == pi2);
  res = (pi1 != pi2);
  res = (pi1 <= pi2);
  res = (pi1 >= pi2);
  res = (pi1 > pi2);
  res = (pi1 < pi2);

  // Void Pointer
  // Vergessen und Einführen von Typinformation
  pv1 = pi1;  // Vergessen
  pv2 = pv1;  // Durchreichen
  pi2 = pv2;  // Einführen

  pi2 = pv2 + 3;   // !! Frage: welche Semantik hat hier +3 ?
  printf("&pv2=%p  &pi2=%p\n", pv2, pi2);
  
  d = pv2 - pv1;  // erlaubt: Differenz zwischen void*

  res = (pv1 < pv2);

  // res = (pi1 < pv2); // Warnung: fehlende Typkonvertierung in Vergleich
  res = (pi1 < (int*) pv2); // "OK": explizite Typkonvertierung per cast

  //
  // -----------------------------------------------------------
  // Nicht erlaubt

  // d = pi2 + pi1;    // Addition von Pointern
  // d = pi2 * pi1;    // Multiplikation von Pointern

  // Void Pointer
  pv2 = &a[4]; // Erlaubt: Initialisierung des Void-Pointers für später

  //d = pi1 - pv1; // Mischform nicht erlaubt: Differenz zwischen int* und void*
  
  //*pv2;        // Warnung: Dereferenzierung eines »void *«-Zeigers
  
  //d = *pv2;    // Fehler: Benutzung eines Wertes der aus Dereferenz eines void* entsteht
  //1 + *pv2;    // Fehler: Benutzung eines Wertes der aus Dereferenz eines void* entsteht
  

  // ---------------------------------------------
  // Avoid compiler warning about unused variables
  if (false) printf("%d %p %p %p %p %d", d, pi1, pi2, pv1, pv2, res);

  return 0; 
}
