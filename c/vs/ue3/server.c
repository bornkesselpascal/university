#include "math.h"
#include <rpc/rpc.h>
#include <math.h>

int * add_1_svc(pair, rqstp)
    intpair * pair;
    struct svc_req *rqstp;
{
    int a = pair->a;
    int b = pair->b;

    return a+b;
}

int * multiply_1_svc(pair, rqstp)
    intpair * pair;
    struct svc_req *rqstp;
{
    int a = pair->a;
    int b = pair->b;

    return a*b;
}
    

int * cube_1_svc(number, rqstp)
    int * number;
    struct svc_req *rqstp;
{
    int cube = (*number)*(*number);
    
    return cube;
}
    
    