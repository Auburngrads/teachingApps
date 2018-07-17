#include "heads/base.h"
#include "heads/constants.hpp"
using namespace constants;
#include <sgpdfl/usrpdf.h>
#include <spgeng/zgtran.h>
#include <utility/dexpc.h>
#include <sgpdfl/pdfggl.h>

//'  PDF of specified general distribution
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

double gpdfl(double y,
             Rcpp::NumericVector gamme,
             int kdist){

double z;
double smalls = 1.0e-08, smpdfl = -1.0e05;
double hlntp = -0.9189385332046794e00;

//  #check for user specified cdf
if(kdist > 100) { return log(usrpdf(y,gamme,kdist)); }

if((kdist > 0) and (kdist < 7)) {
  
    // standardize for location-scale distributions
    z = zgtran((y - gamme.at(0)) / gamme.at(1),kdist);
    if(gamme.at(1) <= smalls) return smpdfl;
  
    if((kdist == 1) or (kdist == 2)) { // sev
      
        return -dexpc(z) + z - gamme.at(2);
      
    } 
    if((kdist == 3) or (kdist == 4)) { // normal
      
        return hlntp - gamme.at(2) - half * z * z;
      
    } 
    if((kdist == 5) or (kdist == 6)) { // logistic
      
        return -z - two * log(one + dexpc(-z)) - gamme.at(2);
      
    } 
}


if((kdist == 7) or (kdist == 8)) { // exponential
 
    z = zgtran(y - gamme.at(0), 1);
    return -dexpc(z) + z;
  
}

if((kdist == 9) or (kdist == 10)) { // generalized gamma
  
    z = zgtran((y - gamme.at(0)) / gamme.at(1),5);
    if(gamme.at(1) <= smalls)  return smpdfl;
    return pdfggl(z,gamme.at(2),gamme.at(3),gamme.at(4),
                    gamme.at(5),gamme.at(6),gamme.at(7));
  
}

if((kdist == 11) or (kdist == 12)) { // regular gamma
  
    z = zgtran(y - gamme.at(0),5);
    return pdfggl(z,0.0e00,gamme.at(1),gamme.at(2),
                           gamme.at(3),gamme.at(4),gamme.at(5));
  
}

return smpdfl;
      
}
