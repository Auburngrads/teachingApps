#include "heads/base.h"

//' Check for overflow/underflow for calls to dexp.
//' Ignore underflow and return 0
//' If overflow, return a big number.

double dexpc(double x){

double small = -700.0e00, big = 700.0e00;
double smexp = 9.859e-305,bigexp = 1.01423e304;

if(x > big) return bigexp ;

if(x < small) return smexp;

return exp(x);

}
