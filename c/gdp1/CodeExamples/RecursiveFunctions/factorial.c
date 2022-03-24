#include<stdio.h>
#include<stdlib.h>

#define OK 0
#define ERROR 1

int factorial(int n) {
	if (n <= 1) {
		return 1;
	} else {
		return n * factorial(n-1);
	}
}


int main (int argc, char * argv[]) {
	if (argc != 2) {
		printf("Bitte eine Zahl eingeben:\n");
		printf("Beispiel:  %s 4 \n", argv[0]);
		return ERROR;
	}

	int z = atoi(argv[1]);

	printf("factorial(%d) = %d\n", z, factorial(z) );

	return OK;
}
