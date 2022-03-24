// siehe http://de.wikipedia.org/wiki/Fibonacci-Folge
//

#include<stdio.h>
#include<stdlib.h>

#define OK 0
#define ERROR 1

// For debugging
#define ENTER 0
#define LEAVE 1

// For debugging
void docstack(int action, int n, int level, char pos[]) {
	int m;
	for (m=level; m > 0; m--) { printf(" ");}
	printf("%s fibonacci(%d) level=%d pos=%s\n",
			action?"Leave":"Enter",n,level,pos);
}

// Rekursive Fassung
// Direkt nach der Definition -> leicht verstaendlich
int fib(int n, int level, char pos[]){
	// Zur Sicherheit werden negative Zahlen abgefangen
	docstack(ENTER,n,level,pos);
	if (n <= 0) {
		docstack(LEAVE,n,level,pos);
		return 0;
	} else if (n == 1) {
		docstack(LEAVE,n,level,pos);
		return 1;
	} else {
		int erg= fib(n-1,level+1,"fst") + fib(n-2,level+1,"snd");
		docstack(LEAVE,n,level,pos);
		return erg;
	}
}

int main (int argc, char * argv[]) {
	if (argc != 2) {
		printf("Bitte eine Zahl eingeben:\n");
		printf("Beispiel:  %s 4 \n", argv[0]);
		return ERROR;
	}

	int z = atoi(argv[1]);
	printf("fibonacci(%d) = %d\n", z, fib(z,0,"from main") );

	return OK;
}
