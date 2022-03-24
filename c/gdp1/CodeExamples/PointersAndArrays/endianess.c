#include<stdio.h>

void dumpArrayAsBytes(unsigned char *a, int anz){
  int i;
  for(i=0; i< anz; i++){
    printf("Byte %d: 0x%x\n", i, a[i]);
  }
}

void dumpArrayAsShort(unsigned short int *a, int anz){
  int i;
  for(i=0; i< anz; i++){
    printf("Short %d: 0x%x\n", i, a[i]);
  }
}

void dumpArrayAsInt(unsigned int *a, int anz){
  int i;
  for(i=0; i< anz; i++){
    printf("Int %d: 0x%x\n", i, a[i]);
  }
}

int main(void){
  unsigned short int as[2][2] = {
    {0x1122, 0x3344},
    {0x5566, 0x7788},
  };

  printf("sizeof(short)=%d\n", sizeof(short));
  printf("\n");

  dumpArrayAsShort((unsigned short *) as, 4); // mit cast
  printf("\n");

  dumpArrayAsBytes((unsigned char *) as, 8);  // mit cast
  printf("\n");

  dumpArrayAsInt((unsigned int *) as, 2);     // mit cast
  printf("\n");

  return 0;
}

