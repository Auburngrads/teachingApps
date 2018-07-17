#include "heads/base.h"
#include "heads/constants.hpp"
using namespace constants;
#include <postkp/dlgama.h>
#include <utility/dexpc.h>

double gaminc(double x,
              double p){
  
//  incomplete gamma function
double tol = 1.0e-16;
double expmin = -70.0e00,expmax = 70.0e00;
double big30 = 1.0e20, bigx = 1.0e10;
double prob, fact, factl, ratio, xi;
double top1, top2, top3, bot1, bot2, bot3;
double ximp, zzadd, zzsub, diff;

prob = zero;
int ier = 0;

if(p <= zero) ier = 1;
if(x <  zero) ier = 2;

if((ier > 0) or (x == zero)) return prob;

fact  = zero;
factl = p * log(x) - x - dlgama(p);

if((factl >= expmax) or (x >= bigx)) {

  prob = one;
  return prob;
}

if(factl > expmin) fact = dexpc(factl);

if((x <= one) or (x < p)) {

// series expansion
        prob  = one;
        xi    = one;
        ratio = p;
line20: ratio = ratio + one;
        xi    = xi * x / ratio;
        prob = prob + xi;
        if(xi > tol) goto line20;
        prob = prob * fact / p;
        return prob;
}

//  calculation by continued fraction
        ximp  = one - p;
        zzadd = ximp + x + one;
        xi = zero;
        top1 = one;
        bot1 = x;
        top2 = x + one;
        bot2 = x * zzadd;
        prob = top2 / bot2;
line32: ximp = ximp + one;
        zzadd = zzadd + two;
        xi    = xi + one;
        zzsub = ximp * xi;
        top3  = zzadd * top2 - zzsub * top1;
        bot3  = zzadd * bot2 - zzsub * bot1;

        if(fabs(bot3 - zero) > 1.0e-6) {

           ratio = top3 / bot3;
           diff  = fabs(prob - ratio);

           if(diff <= tol) {

              if(diff <= tol * ratio) {

                goto exit;

              }

           }

           prob = ratio;

        }

        top1 = top2;
        bot1 = bot2;
        top2 = top3;
        bot2 = bot3;

        if(fabs(top3) < big30) goto line32;

        top1 = top1 / big30;
        bot1 = bot1 / big30;
        top2 = top2 / big30;
        bot2 = bot2 / big30;

        goto line32;

exit: prob = one - prob * fact;

      return prob;
}
