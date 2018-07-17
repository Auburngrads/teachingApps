#include "heads/base.h"
#include "heads/constants.hpp"
using namespace constants;
#include <utility/dexpc.h>

//' PDF(z) for the generalized gamma with shape xk

double pdfggl(double z,
              double sigmal,
              double qq,
              double xk,
              double sqrtxk,
              double xklog,
              double xlgam){

double zmin  = -30.0e00, zmax = 30.0e00;
double hlntp = -0.9189385332046794e00;

if(qq < 0) {
  
  double zt = -z;
  double zs = zt / sqrtxk;
  if(zs > zmax) return zero;
  if(zs < zmin) return zero;
  
  return (xk - half) * xklog - xlgam - sigmal + sqrtxk * zt - xk * dexpc(zs);
  
}

if(qq > 0) {
  
  double zt = z;
  double zs = zt / sqrtxk;
  if(zs > zmax) return zero;
  if(zs < zmin) return zero;
  
  return (xk - half) * xklog - xlgam - sigmal + sqrtxk * zt - xk * dexpc(zs);
  
}

  // pdf(z) for the normal
  return hlntp - sigmal - half * z * z;
  
}