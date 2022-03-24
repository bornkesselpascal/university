// siehe http://de.wikipedia.org/wiki/Fibonacci-Folge
//

#include<stdio.h>
#include<stdlib.h>

#define OK 0
#define ERROR 1

// Iterative Fassung
// Wirkt umstaendlicher, ist aber effizienter
int fibit(int n) {
	int pop;
	if (n <= 0) {
		pop = 0;
	} else if(n == 1) {
		pop = 1;
	} else {
		int k;
		int pop_pre = 1;
		int pop_prepre = 0;
		for (k=2; k <= n; k++) {
			pop = pop_pre + pop_prepre;

			// Vortrag
			pop_prepre = pop_pre;
			pop_pre = pop;
		}
	}
	return pop;
}

int main (int argc, char * argv[]) {
	if (argc != 2) {
		printf("Bitte eine Zahl eingeben:\n");
		printf("Beispiel:  %s 4 \n", argv[0]);
		return ERROR;
	}

	int z = atoi(argv[1]);

	printf("fibonacci_it(%d) = %d\n", z, fibit(z) );

	return OK;
}
