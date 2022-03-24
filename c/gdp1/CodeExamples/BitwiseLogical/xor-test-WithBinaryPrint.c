#include <stdio.h>

#include "tobinary.c"

// Definiere logisches Exlusiv-Oder als Makro
// Vorsicht bei Makros
// 1) immer alle Argumente Klammern
// 2) Definition muss auf einer Zeile sein!

#define XOR(x,y) (( (x) && !(y)) || (!(x) && (y)))

int main(void) {
    char buf[33];
    // Als Typ mit zwei Byte
    //unsigned short int a,b, logical, bitwise;

    // Als Typ mit 4 Byte ohne Vorzeichen
    unsigned int a,b, logical, bitwise;

    // Hex
    //a = 0x3;
    //b = 0xc;

    // Binaer
    a = 0b00000011;
    b = 0b00001100;

    printf("Wert von a: 0b%s\n", uint32tobin(a, buf) );
    printf("Wert von b: 0b%s\n", uint32tobin(b, buf) );
    printf("Size von a in Bytes: %d\n", sizeof a);

    logical = XOR(a,b);
    bitwise = a^b;

    printf("logische Verknuepfung, Wert von XOR(a,b) : 0b%s\n", uint32tobin(logical, buf) );
    printf("bitweise Verknuepfung, Wert von      a^b : 0b%s\n", uint32tobin(bitwise, buf));

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
