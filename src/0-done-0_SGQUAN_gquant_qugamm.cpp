#include "heads/base.h"
#include "heads/constants.hpp"
using namespace constants;
using namespace std;
#include <utility/dsign.h>
#include <utility/dsqrtc.h>
#include <utility/wqm_quant.h>
#include <spgeng/gaminc.h>
#include <postkp/dlgama.h>
#include <utility/dexpc.h>

//' Quantile of gamma distribution with shape at probability p

double qugamm(double p,
              double shape){
  
Rcpp::NumericVector a;
double xnine = 9.0e00;
// tol1 is the requested relative accuracy in the quantile
// tol2 is the requested absolute accuracy in the probability
double tol1 = 1.0e-14,tol2 = 1.0e-24;
int maxit = 100;
a = NumericVector::create( 1.264616e-2, -1.425296e-2,
                           1.400483e-2, -5.886090e-3,
                          -1.091214e-2, -2.304527e-2,
                           3.135411e-3, -2.728484e-4, 
                          -9.699681e-3,  1.316872e-2,
                           2.618914e-2, -0.2222222e00,
                           5.406674e-5,  3.483789e-5,
                          -7.274761e-4,  3.292181e-3,
                          -8.729713e-3, 0.4714045e00, 1.0e00);
                          
//  plast was undefined before
double small  = 1.0e-300;
double small2 = small / tol1;
double plast  = zero;
double pr = p, f1, f2, dqgm, p1, pdif, del1, dlast, pabs;
int i = 1;

if(shape <= zero) shape = 1.0e-4;

//  #exponential special case
if(shape ==  one) {
  
  return -log(one - pr);
  
}

// setup error message
// if((p.ge.zero).and.(p.lt.one))go to 2

if(fabs(p - zero) < 0.00001) {
  
   // if p=0, return qugamm=0
   return zero;
  
}

if(shape < half) {
  
// small shape, infinite density at 0
// try simplaster wilson-hilferty approx but revert to a small
// number of the first approx is negative

   f1   = one / (xnine * shape);
   dqgm = one - f1 + wqm_quant(pr,3) * dsqrtc(f1);
   dqgm = dqgm * dqgm * dqgm * shape * two;
   
   if(dqgm <= zero) dqgm = 0.0001e00;
       
 } else {

   // high order wilson-hilferty approx
   // use to find a good start value for 
   // the nr iterations
   f1 = half / shape;
   f2 = dsqrtc(f1) * wqm_quant(pr,3);
   
   dqgm = (((a.at(0) + a.at(1) * f2) * f1 + (((a.at(2) + a.at(3) * f2)\
             * f2 + a.at(4)) * f2 + a.at(5))) * f1 +\
               (((((a.at(6) + a.at(7) * f2) * f2 + a.at(8)) * \
               f2 + a.at(9)) * f2 + a.at(10)) * f2 + a.at(11)))\
             * f1 + (((((a.at(12) * f2 + a.at(13)) * f2 + a.at(14))\
             * f2 + a.at(15)) * f2 + a.at(16)) * f2 * f2 + a.at(17))\
             * f2 + a.at(18);
             
   dqgm = dqgm * dqgm * dqgm * shape;

}

// begin nr iterations

while(i <= maxit){
  
      p1   = gaminc(dqgm,shape);
      pdif = pr - p1;
      pabs = fabs(pdif);
             
      // check for accuracy at current estimate (abs accuracy in p)
      if(pabs <= tol2) return dqgm;
      
      // if i=1 or if we saw an improvement, go to get next delta
      if(!((pabs < plast) or (i == 1))) {
      
      // otherwise take a half step and try again
      // fcheck (but was not sure) thinks that del1 has not been defined above???
      // perhaps it just got fooled
      
            del1 = -del1 / two;
          
        } else {
        
          del1 = log(pabs) - (shape - one) * log(dqgm) + dqgm + dlgama(shape);
          del1 = dsign(dexpc(del1), pdif);
            
          // make sure that we do not cross 0
          if(-del1 > dqgm) del1 = -0.9e00 * dqgm;
          
          //  #switch to a half step if we appear to have gone in the wrong direction
          if(dsign(one,pdif) != dsign(one,del1)) {
            
             del1 = dsign(del1 / two,pdif);
          
          }
      }
      // F77 found this 08/28/94 -> del1 = dsign(dl/two,pdif)
      // save old values
      dlast = fabs(del1);
      plast = pabs;
      
      // after passing all tests, we can update
      dqgm = max(dqgm + del1,small);
      
      // check relative accuracy of dqgm if it is not too close to 0
      if(dqgm >= small2){
        
         if(dlast <= dqgm * tol1) return dqgm;
         
      }
      
      i = i + 1;

}

return dqgm;

}