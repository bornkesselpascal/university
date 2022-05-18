#include "math.h"
#include <rpc/rpc.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[])
{
    int result = 0;
    
    if (argc < 2)
    {
        printf("1Bitte überprüfen Sie die Kommandozeilenparameter.\n");
        return -1;
    }

    if (strcmp(argv[1], "add") == 0)
    {
        // ADDIEREN
        if (argc < 5)
        {
            printf("2Bitte überprüfen Sie die Kommandozeilenparameter.\n");
            return -1;
        }

        intpair numbers;
        numbers.a = atoi(argv[3]);
        numbers.b = atoi(argv[4]);

        CLIENT *cl;
        cl = clnt_create (argv[2], MATHPROG, MATHVERS, "tcp");

        result = *add_1(&numbers, cl);
    }
    else if (strcmp(argv[1], "multiply") == 0)
    {
        // MULTIPLIZIEREN
        if (argc < 5)
        {
            printf("Bitte überprüfen Sie die Kommandozeilenparameter.\n");
            return -1;
        }

        intpair numbers;
        numbers.a = atoi(argv[3]);
        numbers.b = atoi(argv[4]);

        CLIENT *cl;
        cl = clnt_create (argv[2], MATHPROG, MATHVERS, "tcp");

        result = *multiply_1(&numbers, cl);
    }
    else if (strcmp(argv[1], "cube") == 0)
    {
        // QUADRIEREN
        if (argc < 4)
        {
            printf("Bitte überprüfen Sie die Kommandozeilenparameter.\n");
            return -1;
        }

        int a = atoi(argv[3]);

        CLIENT *cl;
        cl = clnt_create (argv[2], MATHPROG, MATHVERS, "tcp");

        result = *cube_1(&a, cl);
    }
    else
    {
        printf("3Bitte überprüfen Sie die Kommandozeilenparameter.\n");
        return -1;
    }

    printf("result = %d\n", result);
}