#include "heads/base.h"
#include "heads/constants.hpp"
using namespace constants;
#include <utility/wqm_pinv.h>

//' location-scale distribution quantiles

double wqm_quant(double p,
                 int kdist){

double smallp = 1.0e-25;
double wqmquant = 0.0e00;
double d = p;

if(p < smallp) d = smallp;
if(p >= one)   d = one - 1.0e-15;

//  smallest extreme value distribution
if((kdist == 1) or (kdist == 2)) {

    wqmquant = log(-log(one - d));

}
// normal distribution
if((kdist == 3) or (kdist == 4)) {

    if(d < half) {

       wqmquant = -wqm_pinv(d);

    } else {

       wqmquant = wqm_pinv(one - d);

    }

}
//  logistic distribution
if((kdist == 5) or (kdist == 6)) {

    wqmquant = -log(one / d - one);

}
//  largest extreme value distribution
if((kdist == 7) or (kdist == 8)) {

    wqmquant = -log(-log(d));

}
      return wqmquant;
}
