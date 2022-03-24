// How can we force the language C to pass an array by value?
//
// We show a bold trick using a structure as envelope for the array.
// Arrays have reference semantics and are not passed by value.
// However, structures have value semantics.

#include <stdio.h>
#include <stdlib.h>

struct array_envelope {
  int len;
  int values[4];
};

void dump_array(struct array_envelope e) {
  int i;
  for (i=0; i < e.len; i++) {
    printf("values[%d] = %x\n", i, e.values[i]);
  }
}

int main() {
  struct array_envelope the_envelope;
  the_envelope.values[0] = 0x11111111;
  the_envelope.values[1] = 0x22222222;
  the_envelope.values[2] = 0x33333333;
  the_envelope.values[3] = 0x44444444;
  the_envelope.len = sizeof(4);

  dump_array(the_envelope);

  return EXIT_SUCCESS;
}

