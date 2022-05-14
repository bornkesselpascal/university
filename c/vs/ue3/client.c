#include "math.h"
#include <rpc/rpc.h>

int main()
{
    char* servername = "localhost";
    int num1 = 3;
    int num2 = 4;

    CLIENT *cl;
    cl = clnt_create (servername, MATHPROG, MATHVERS, "tcp");

    struct intpair numbers;
    numbers.a = num1;
    numbers.b = num2;
    

    int result = add_1(&numbers, cl);
    printf("%d\n", result);
}