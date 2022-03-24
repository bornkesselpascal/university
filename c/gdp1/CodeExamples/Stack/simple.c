// Dieses Programm im Debugger anschauen.
// Assembler ausgeben mittels:
// 
// (gdb) disass /rm main
//


int main() {
  int x, y, z;

  x = 0x11223344;
  y = 0x55667788;

  z = x + y;

  return z;
}
