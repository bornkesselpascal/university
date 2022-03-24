// Two dimensional vectors and some functions

#include<stdio.h>   // for printf
#include<stdlib.h>  // for EXIT_SUCESS
#include<math.h>    // for pow() and sqrt()

// We define the type alias 'vec' for an anonymous structure
typedef struct {
  float x;
  float y;
} vec;

// Vector addition: functional style
// We pass parameters by value
// We return a vec as result!
vec add_vec(vec v, vec w) {
  vec r;
  r.x = v.x + w.x;
  r.y = v.y + w.y;
  return r;
}

// Vector negation: functional style
// We pass parameters by value
// We return a vec as result!
vec neg_vec(vec v) {
  vec r;
  r.x = -v.x;
  r.y = -v.y;
  return r;
}

int main() {
  vec v1={ 9.0,17.0 };
  vec v2,v3;

  v2.x = 12.0;
  v2.y = 13.0;

  v3 = add_vec(v1,v2);
  printf("Vector addition:\n"
      "(%5.2f, %5.2f) + "
      "(%5.2f, %5.2f) = "
      "(%5.2f, %5.2f)\n",
      v1.x,v1.y,
      v2.x,v2.y,
      v3.x,v3.y);

  v3 = neg_vec(v2);
  printf("Vector negation:\n"
      "-(%5.2f, %5.2f) = "
      "(%5.2f, %5.2f)\n",
      v2.x,v2.y,
      v3.x,v3.y);

  v3 = add_vec(v1,neg_vec(v2));
  printf("Vector subtraction:\n"
      "(%5.2f, %5.2f) - "
      "(%5.2f, %5.2f) = "
      "(%5.2f, %5.2f)\n",
      v1.x,v1.y,
      v2.x,v2.y,
      v3.x,v3.y);


  return EXIT_SUCCESS;
}
