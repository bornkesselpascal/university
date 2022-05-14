#include "math.h"
#include <rpc/rpc.h>
#include <math.h>

int * add_1_svc(pair, rqstp)
    intpair * pair;
    struct svc_req *rqstp;
{
    int a = pair->a;
    int b = pair->b;
    int result = a+b;

    return result;
}

int * multiply_1_svc(pair, rqstp)
    intpair * pair;
    struct svc_req *rqstp;
{
    int a = pair->a;
    int b = pair->b;
    int result = a*b;

    return result;
}
    

int * cube_1_svc(number, rqstp)
    int * number;
    struct svc_req *rqstp;
{
    int result = (*number)*(*number);
    
    return result;
}
    
    