// siehe http://de.wikipedia.org/wiki/Fibonacci-Folge
//

#include<stdio.h>
#include<stdlib.h>

// Rekursive Fassung
// Direkt nach der Definition -> leicht verstaendlich
int fib(int n){
	// Zur Sicherheit werden negative Zahlen abgefangen
	if (n <= 0) {
		return 0;
	} else if (n == 1) {
		return 1;
	} else {
		return fib(n-1) + fib(n-2);
	}
}

int main (int argc, char * argv[]) {
	if (argc != 2) {
		printf("Bitte eine Zahl eingeben:\n");
		printf("Beispiel:  %s 4 \n", argv[0]);
		return EXIT_FAILURE;
	}

	int z = atoi(argv[1]);

	printf("fibonacci(%d) = %d\n", z, fib(z) );

	return EXIT_SUCCESS;
}
