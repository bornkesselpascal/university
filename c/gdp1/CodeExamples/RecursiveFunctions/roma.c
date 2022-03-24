#include<stdio.h>

void f(char *s) {
	if (*s != '\0') {
		// Falls String nicht leer, rekursiver Aufruf von f,
		// wobei aber Pointer um ein Zeichen weiter nach
		// rechts verschoben wird. 
		// Mit jedem rekursiven Aufruf wird String kuerzer
		f(s + 1);

		// Nach Auftauchen aus Rekursion das erste Zeichen des
		// Strings ausgeben. Die Buchstaben des Worts werden damit
		// von hinten nach vorne ausgegeben 
		printf("%c", *s);
	}
}

int main () {
	f("ROMA");
	printf("\n");

	return 0; 
}

