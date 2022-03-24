// ----------------------------------------
// Write a C programm that resembles the
// assembler programm adder.asm
// ----------------------------------------
// Key idea for the C code: use global variables
//
// Compile:
// mkdir -p bin
// gcc -o bin/adder-spy adder-spy.c
// gdb -q bin/adder-spy
//
// in gdb, disassemble code an spy.

#include <stdio.h>

//char* const prompt_n1 = "Bitte geben Sie die erste  Zahl ein: ";
char const prompt_n1[] = "Bitte geben Sie die erste  Zahl ein: ";
char const prompt_n2[] = "Bitte geben Sie die zweite  Zahl ein: ";
char const scanf_format_read_int[] = "%d";
char const prompt_res[] = "Die Summe der beiden Zahlen %d und %d ist %d\n";
char const prompt_myprint_int[] = "Das Argument fuer myprint_int lautet: %d\n";

int n1;
int n2;
int res;

void myprint_int(int i){
  printf(prompt_myprint_int, i);
}

int main(){
  printf(prompt_n1);
  scanf(scanf_format_read_int, &n1);

  printf(prompt_n2);
  scanf(scanf_format_read_int, &n2);

  res = n1 + n2;

  printf(prompt_res, n1, n2, res);

  myprint_int(res);

  return 0;

}

