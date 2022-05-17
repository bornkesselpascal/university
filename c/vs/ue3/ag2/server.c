#include "math.h"
#include <rpc/rpc.h>
#include <stdio.h>

int * add_1_svc(pair, rqstp)
    intpair * pair;
    struct svc_req *rqstp;
{
    printf("Funktion ADD aufgerufen.\n");
    int a = pair->a;
    int b = pair->b;

    int r = a + b;
    printf("Ergebnis berechnet. %d + %d = %d.\n", a, b, r);
    return &r;
}

int * multiply_1_svc(pair, rqstp)
    intpair * pair;
    struct svc_req *rqstp;
{
    printf("Funktion MULTIPLY aufgerufen.\n");
    int a = pair->a;
    int b = pair->b;

    int r = a * b;
    printf("Ergebnis berechnet.\n");
    return &r;
}

int * cube_1_svc(a, rqstp)
    int * a;
    struct svc_req *rqstp;
{
    printf("Funktion CUBE aufgerufen.\n");

    int r = (*a) * (*a);
    printf("Ergebnis berechnet.\n");
    return &r;
}