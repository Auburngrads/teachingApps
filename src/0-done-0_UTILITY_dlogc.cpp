#include "heads/base.h"

//' check for negative arg of log. 
//' if ok, just return the log, 
//' otherwise return -big.

double dlogc(double x) {
  
double zero = 0.0e00, big = 1.0e20;
  
if(x <= zero) return -big;

   return log(x);
}
