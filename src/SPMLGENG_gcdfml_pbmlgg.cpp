#include "heads/base.h"
#include "heads/constants.hpp"
using namespace constants;
#include <utility/dexpc.h>
#include <utility/wqm_dxerc.h>
#include <spgeng/gaminc.h>

//' Log of 1-cdf for the generalized gamma with shape xk

double pbmlgg(double z,
              double qq,
              double sqrtxk,
              double xk){

double small = 1.0e-30;
    
if(qq < 0) {
  
  double zt = xk * dexpc(-z/sqrtxk);
  return log(std::max(gaminc(zt,xk),small));
  
}

if(qq > 0) {
  
  double zt = xk * dexpc(z / sqrtxk);
  return log(std::max(one - gaminc(zt,xk),small));
  
}

  return log(half * wqm_dxerc(-z * root));
  
}