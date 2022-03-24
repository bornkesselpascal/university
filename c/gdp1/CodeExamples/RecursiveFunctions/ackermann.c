// Siehe http://www.tutego.de/java/articles/Ackermann-Funktion.html
// Die Ackermann-Funktion waechst schneller als jede primitiv rekursive
// Funktion (F. Ackermann 1926)
// ackermann(0,0) = 1
// ackermann(4,0) = 13
// ackermann(5,0) = 65533
// ackermann(3,5) = 253
// ackermann(4,1) = 65533
// Groessere Argumente fuehren sofort zu Ueberlauf

#include<stdio.h>
#include<stdlib.h>

#define OK 0
#define ERROR 1

long ackermann( long n, long m ) {
	if ( n == 0 ) {
		return m + 1;
	} else if ( m == 0 ) {
		return ackermann( n - 1, 1 );
	} else {
		return ackermann( n - 1, ackermann(n, m - 1) );
	} 
}


int main (int argc, char * argv[]) {
	if (argc != 3) {
		printf("Bitte 2 Zahlen eingeben:\n");
		printf("Beispiel:  %s 2 3 \n", argv[0]);
		return ERROR;
	}

	int z1 = atoi(argv[1]);
	int z2 = atoi(argv[2]);

	printf("ackermann(%d,%d) = %ld\n", z1, z2, ackermann(z1,z2) );

	return OK;
}
