// Berechne den Abstand zwischen zwei Punkten in der Ebene (zweidimensional).
// Gegeben sind die karthesischen Koordinaten der Punkte.
//
// Variation: Einsatz von 'typedef'

// Dieses Programm kompiliert und funktioniert wie gewuenscht.
// Die Verwendung der Call-By-Value Semantik von Strukturen ist
// aber unueblich.
// Bei grossen Strukturen ist das Kopieren der Strukturen
// beim Aufruf und bei der Rueckgabe nicht performant genug.

#include<stdio.h>   // fuer printf
#include<stdlib.h>  // fuer EXIT_SUCESS
#include<math.h>    // fuer pow() und sqrt()

// Falls Struktur in mehreren Funktionen verwendet werden soll, muss sie
// im global Scope definiert werden! Sonst kennen die anderen Funktionen
// den Typ nicht.

typedef struct point {
  float x;
  float y;
} point_t;  // hier Alias-Name point_t. Der Alias-Name darf sogar identisch mit dem Eitkett sein!

// Berechne den Abstand zweier Punkte
// Die beiden Punkte werden per-value ubergeben.
// Beim Aufruf der Funktion wird also eine Kopie der Strukturen gemacht.
float compute_distance(point_t p, point_t q) {
  return sqrt(pow(p.x -q.x, 2) + pow(p.y - q.y, 2));
}

int main() {
  point_t p1={ 9.0,17.0 };
  point_t p2;

  p2.x = 12.0;
  p2.y = 13.0;

  float distance = compute_distance(p1,p2); // Punkte werden in Kopie uebergeben

  printf("Abstand zwischen "
      "(%5.2f, %5.2f) und "
      "(%5.2f, %5.2f) ist %5.2f\n",
      p1.x,p1.y,
      p2.x,p2.y,
      distance);

  return EXIT_SUCCESS;
}
