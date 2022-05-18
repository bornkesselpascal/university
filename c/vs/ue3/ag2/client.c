#include "math.h"
#include <rpc/rpc.h>

int main()
{
    char* servername = "localhost";
    intpair numbers;

    numbers.a = 3;
    numbers.b = 4;


    CLIENT *cl;
    cl = clnt_create (servername, MATHPROG, MATHVERS, "tcp");

    int r = *multiply_1(&numbers, cl);

    printf("ERFOLG. r=%d\n", r);
}