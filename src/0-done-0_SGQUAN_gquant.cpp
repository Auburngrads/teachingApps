#include "heads/base.h"
#include "heads/constants.hpp"
using namespace constants;
#include <utility/wqm_quant.h>
#include <sgquan/qugamm.h>
#include <utility/dlogc.h>

double gquant(double p,
              Rcpp::NumericVector gamme,
              int kdist){

double res = 6.5;

//  #check for user specified cdf

if((kdist > 0) and (kdist < 7)) {
  
    return gamme.at(0) + wqm_quant(p,kdist) * gamme.at(1);
  
}


if((kdist == 7) or (kdist == 8)) { // exponential
 
    return gamme.at(0) + wqm_quant(p,1);
  
}

if((kdist == 9) or (kdist == 10)) { // generalized gamma
  
  if(gamme.at(3) < 0){
    
     return gamme.at(0) - dlogc(qugamm(one - p,gamme.at(4)) / gamme.at(4)) * (gamme.at(1) * gamme.at(5));
    
  }
  
  if(gamme.at(3) > 0){
    
     return gamme.at(0) + dlogc(qugamm(p,      gamme.at(4)) / gamme.at(4)) * (gamme.at(1) * gamme.at(5));
    
  }
    
     return gamme.at(0) + wqm_quant(p,3) * gamme.at(1);
  
}

if((kdist == 11) or (kdist == 12)) { // regular gamma
  
  if(gamme.at(1) < 0){
    
    return gamme.at(0) - dlogc(qugamm(one - p,gamme.at(2)) / gamme.at(2)) * (gamme.at(3));
    
  }
  
  if(gamme.at(1) > 0){
    
    return gamme.at(0) + dlogc(qugamm(p,      gamme.at(2)) / gamme.at(2)) * (gamme.at(3));
    
  }
  
  return gamme.at(0) + wqm_quant(p,3);
  
}

return res;
      
}
