#include "heads/base.h"
#include "heads/constants.hpp"
using namespace constants;
#include <spgeng/usrcdf.h>
#include <spgeng/zgtran.h>
#include <utility/dexpc.h>
#include <spgeng/pbgg.h>
#include <spgeng/usrcdf.h>
#include <utility/wqm_dxerc.h>

//'  CDF of specified general distribution
//'  
//'  gamme(i) for user-specified distributions
//'  
//'  dist      i:   1    2    3    4    5    6    7    8    9    10    11
//'----------------------------------------------------------------------
//'  sev            m    s    ls
//'  normal         m    s    ls
//'  logistic       m    s    ls
//'  log-exponent   m
//'  log-gengamma   m    s    ls   q    k    sk   lk  lgk
//'  log-gamma      m    q    k    sk   lk   gk

double gcdf(double y,
            Rcpp::NumericVector gamme,
            int kdist){

double res = 6.5, z;

//  #check for user specified cdf
if(kdist > 100) { return usrcdf(y,gamme,kdist); }

if((kdist > 0) and (kdist < 7)) {
  
    // standardize for location-scale distributions
    z = zgtran((y - gamme.at(0)) / gamme.at(1),kdist);
  
    if((kdist == 1) or (kdist == 2)) { // sev
      
        return one - dexpc(-dexpc(z));
      
    } 
    if((kdist == 3) or (kdist == 4)) { // normal
      
        return half * wqm_dxerc(-z * root);
      
    } 
    if((kdist == 5) or (kdist == 6)) { // logistic
      
        return one / (one + dexpc(-z));
      
    } 
}


if((kdist == 7) or (kdist == 8)) { // exponential
 
    z = zgtran(y - gamme.at(0), 1);
    return one - dexpc(-dexpc(z));
  
}

if((kdist == 9) or (kdist == 10)) { // generalized gamma
  
    z = zgtran((y - gamme.at(0)) / gamme.at(1),5);
    res = pbgg(z,gamme.at(3),gamme.at(5),gamme.at(4));
  
}

if((kdist == 11) or (kdist == 12)) { // regular gamma
  
    z = zgtran(y - gamme.at(0),5);
    return pbgg(z, gamme.at(1),gamme.at(3),gamme.at(2));
  
}

return res;
      
}
