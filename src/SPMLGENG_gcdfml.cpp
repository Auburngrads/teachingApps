#include "heads/base.h"
#include <spmlgeng/gcdfml.h>
#include "heads/constants.hpp"
#include <spgeng/zgtran.h>
#include <spgeng/usrcdf.h>
#include <utility/dexpc.h>
#include <slsinf_and_vavar/wqm_dxerc.h>
#include <spmlgeng/pbmlgg.h>

using namespace constants;

//' Compute log(one-cdf)

double gcdfml(double y,
              Rcpp::NumericVector gamme,
              int kdist) {
  
double GCDFML, z;
  
if(kdist > 100) GCDFML = log(one - usrcdf(y, gamme, kdist));

  
if((kdist > 0) & (kdist < 7)) {
  
    z = zgtran((y - gamme.at(0)) / gamme.at(1), kdist);
  
    // SEV
    if((kdist == 1) or (kdist == 2)) {
      
      GCDFML = -dexpc(z);
      
    }
    
    // Normal
    if((kdist == 3) or (kdist == 4)) {
      
      GCDFML = log(half * wqm_dxerc(z * root));
      
    }
    
    // Logistic
    if((kdist == 5) or (kdist == 6)) {
      
      GCDFML = -z - log(one + dexpc(-z));
      
    }

    
}

// Exponential
if((kdist == 7) or (kdist == 8)) {
  
    z = zgtran(y - gamme.at(0),1);
    GCDFML = -dexpc(z);
  
}


// Generalized Gamma
if((kdist == 9) or (kdist == 10)) {
  
    z = zgtran(y - gamme.at(0),5);
    GCDFML = pbmlgg(z, gamme.at(1),gamme.at(3),gamme.at(2));
  
}

// Ordinary Gamma
if((kdist == 11) or (kdist == 12)) {
  
    // #gcdfml=f(z,q,sqrtxk,xk);
    
}

      return GCDFML;
  
}
