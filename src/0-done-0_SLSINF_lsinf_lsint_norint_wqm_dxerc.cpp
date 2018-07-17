#include "heads/base.h"
#include "heads/constants.hpp"
using namespace constants;

//'  function to compute the complimentary error function

double wqm_dxerc(double x){

  return two * R::pnorm(x * sqrt(two), 0, 1, false, false);
  
}
