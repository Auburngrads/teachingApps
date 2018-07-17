#include "heads/base.h"
#include "heads/constants.hpp"
using namespace constants;
#include <utility/dexpc.h>
#include <utility/wqm_dxerc.h>
#include <spgeng/gaminc.h>

//' CDF(z) for the generalized gamma with shape xk

double pbgg(double z,
            double qq,
            double sqrtxk,
            double xk){

  
if(qq < 0) {
  
  double zt = xk * dexpc(-z/sqrtxk);
  return one - gaminc(zt,xk);
  
}

if(qq > 0) {
  
  double zt = xk * dexpc(z / sqrtxk);
  return gaminc(zt,xk);
  
}

  // cdf(z) for the normal
  return half * wqm_dxerc(-z * root);
  
}