// Two dimensional vectors and some functions
// We pass arguments by address (procedural style)

#include<stdio.h>   // for printf
#include<stdlib.h>  // for EXIT_SUCESS
#include<math.h>    // for pow() and sqrt()

// We define the type alias 'vec' for an anoymous structure
typedef struct {
  float x;
  float y;
} vec;

// Vector addition: procedural style
// We pass parameters by reference
// Result is passed by reference as well
void add_vec(vec* v, vec* w, vec* r) {
  r->x = v->x + w->x;
  r->y = v->y + w->y;
  return;
}

// Vector negation: procedural style
// We pass parameters by reference
// Result is passed by reference as well
void neg_vec(vec* v, vec* r) {
  r->x = -v->x;
  r->y = -v->y;
  return;
}

int main() {
  vec v1={ 9.0,17.0 };
  vec v2,v3;

  v2.x = 12.0;
  v2.y = 13.0;

  add_vec(&v1,&v2,&v3);

  printf("Vector addition:\n"
      "(%5.2f, %5.2f) + "
      "(%5.2f, %5.2f) = "
      "(%5.2f, %5.2f)\n",
      v1.x,v1.y,
      v2.x,v2.y,
      v3.x,v3.y);

  neg_vec(&v2,&v3);

  printf("Vector negation:\n"
      "-(%5.2f, %5.2f) = "
      "(%5.2f, %5.2f)\n",
      v2.x,v2.y,
      v3.x,v3.y);

  // Since we do not like to override vectors we need on more variable v4
  vec v4;
  add_vec(&v1,&v3,&v4); // we use result of negation in v3

  printf("Vector subtraction:\n"
      "(%5.2f, %5.2f) - "
      "(%5.2f, %5.2f) = "
      "(%5.2f, %5.2f)\n",
      v1.x,v1.y,
      v2.x,v2.y,
      v4.x,v4.y);

  return EXIT_SUCCESS;
}
