// Achtung: dieses Programm kompiliert nicht
// Es enthaelt einen Denkfehler. Welchen?

#include<stdio.h>   // fuer printf
#include<stdlib.h>  // fuer EXIT_SUCESS
#include<math.h>    // fuer pow() und sqrt()


float compute_distance(struct point p, struct point q) {
  return sqrt(pow(p.x -q.x, 2) + pow(p.y - q.y, 2));
}

int main() {
  struct point {
    float x;
    float y;
  } p1,p2;

  p1.x =  9.0;
  p1.y = 17.0;

  p2.x = 12.0;
  p2.y = 13.0;

  float distance = compute_distance(p1,p2);

  printf("Abstand zwischen "
      "(%5.2f, %5.2f) und "
      "(%5.2f, %5.2f) ist %5.2f\n",
      p1.x,p1.y,
      p2.x,p2.y,
      distance);

  return EXIT_SUCCESS;
}
