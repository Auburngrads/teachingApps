#include "heads/base.h" 
#include "heads/constants.hpp"
using namespace constants;

//' Transformation of the standardized values to 
//' avoid overflow start trans at xk, with an asym 
//' limit beyond 2*xk

double zgtran(double z, int kdist){
  
  Rcpp::NumericVector xkp, xkm, txkp, txkm;
  
  xkp  = NumericVector::create( 2.15e00, 2.15e00, 4.0e00, 4.0e00,  9.5e00,  9.5e00);
  xkm  = NumericVector::create(-9.5e00 ,-9.5e00 ,-4.0e00,-4.0e00, -9.5e00, -9.5e00);
  txkp = NumericVector::create( 4.2e00 , 4.2e00 , 7.9e00, 7.9e00, 18.9e00, 18.9e00);
  txkm = NumericVector::create(-18.9e00,-18.9e00,-7.9e00,-7.9e00,-18.9e00,-18.9e00);
  
  //      call gtltp(ltp)
  //      if(ltp.eq.0) go to 1001
  
  if(z > xkp.at(kdist)) { // too big
    
    double zmxkp  = z - xkp.at(kdist);
    return xkp.at(kdist) + zmxkp / (one + zmxkp / xkp.at(kdist));
    
  }
  
  if(z > xkm.at(kdist)) {
    
    double res = z;
    if(z > txkp.at(kdist)) res = txkp.at(kdist);
    if(z < txkm.at(kdist)) res = txkm.at(kdist);
    return res;
    
  }
  
  // too small
  double zmxkm = z - xkm.at(kdist);
  return xkm.at(kdist) + zmxkm / (one + zmxkm / xkm.at(kdist));
  
}