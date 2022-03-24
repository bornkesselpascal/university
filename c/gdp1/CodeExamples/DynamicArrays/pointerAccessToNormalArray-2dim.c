#include <stdlib.h>
#include <stdio.h>

int main() {
  int na[3][4]={
    { 11, 12, 13, 14 },
    { 21, 22, 23, 24 },
    { 31, 32, 33, 34 },
  };

  int i = 1;
  int j = 3;
  int val;

  val = na[i][j];
  printf("via na[i][j]:%d\n", val);
  
  // Nachfolgende Code-Zeile ist nicht korrekt, da Array na nicht den Typ (int*) hat.
  // Darum funktioniert die Pointer-Arithmetik nicht wie gewünscht.
  // printf("%d\n",                              *(       na     + (i * 4 + j)));

  // Lies: na ist die Adresse auf ein int-Array mit 4 Spalten.
  // Man muss einen expliziten Cast machen auf Typ (int*)
  // Dann funktioniert es wie auf der Folie beschrieben
  val = *( (int*)na + i*4 + j);
  printf("via *( (int*)na + i*4 + j):%d\n", val);

  // Diese Variante ist zunächst erstaunlich: welcher Typ wird hier für na angenommen?
  // Es wird ja faktisch die gleiche Syntax wie bei der APA-Struktur verwendet!
  val = *(  *( na + i) + j  );
  printf("via *( *(              na + i) + j ):%d\n", val);

  // Array na wurde definiert als int na[3][4] und hat somit den Typ 'int (*)[4]'
  // Dadurch ist dann die Syntax identisch.
  // Der Typ 'int (*)[4]' ist leider schwer zu erklären.
  // Darum nicht auf der Folie.
  val = *(  *( (int (*)[4])na + i) + j  );
  printf("via *( *( (int (*)[4]) na + i) + j ):%d\n", val);

  return EXIT_SUCCESS;
}

