#include <stdio.h>

// Definiere logisches Exlusiv-Oder als Makro
// Vorsicht bei Makros
// 1) immer alle Argumente Klammern
// 2) Definition muss auf einer Zeile sein!

#define XOR(x,y) (( (x) && !(y)) || (!(x) && (y)))

int main(void) {
    // Als Typ mit zwei Byte
    //unsigned short int a,b, logical, bitwise;

    // Als Ganzzahl mit einem Byte; char ist ein Zahltyp!!!
    char a,b, logical, bitwise;

    // Hex
    //a = 0x3;
    //b = 0xc;

    // Binaer
    a = 0b00000011;
    b = 0b00001100;

    printf("Wert von a: 0x%0x\n", a);
    printf("Wert von b: 0x%0x\n", b);
    printf("Size von a in Bytes: %d\n", sizeof a);

    logical = XOR(a,b);
    bitwise = a^b;

    printf("logische Verknuepfung, Wert von XOR(a,b) : 0x%0x\n", logical);
    printf("bitweise Verknuepfung, Wert von      a^b : 0x%0x\n", bitwise);

    // Verwende Wert der Verknuepfungen in Bedingung
    if (logical) {
        printf("Wert von XOR(a,b) wird als 'wahr'   interpretiert\n");
    } else {
        printf("Wert von XOR(a,b) wird als 'falsch' interpretiert\n");
    }

    if (bitwise) {
        printf("Wert von      a^b wird als 'wahr'   interpretiert\n");
    } else {
        printf("Wert von      a^b wird als 'falsch' interpretiert\n");
    }


    return 0;
}
