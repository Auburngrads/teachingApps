#include "heads/base.h"
#include "heads/constants.hpp"
using namespace constants;
#include <utility/wqm_dxerc.h>

double g(double x) {

  double numer = wqm_dxerc(x / sqrt(2.0e0));

  return  numer / 2.0e0;

}

double gp(double x){

  return exp(-x * x / 2.0e0) / dr;

}

//'  Odeh's inverse normal with one iteration
//'  of Newton for polish.

double wqm_pinv(double p){

double a0 = 0.505300845045718e-1;
double a1 = 0.6207981783784e0;
double a2 = 1.0e0;
double a3 = 0.255758400033573e0;
double a4 = 0.120012384541901e-1;
double a5 = 0.274100549062517e-4;
double a6 = -0.109846617732390e-6;

double b0 = 0.129635913467631e-1;
double b1 = 0.252771250307626e0;
double b2 = 0.713433125153414e0;
double b3 = 0.472899800222222e0;
double b4 = 0.722351199288358e-1;
double b5 = 0.221326694412374e-2;

double wqmpinv = 0.0e00;
double y, x, xu, xb;

if(p != 0.5e0) {

   y  = sqrt(-2.0e0 * log(p));

   xu = ((((((y * a6 + a5) * y + a4) * y + a3) * y + a2) * y + a1) * y + a0);
   xb = (((((y * b5 + b4) * y + b3) * y + b2) * y + b1) * y + b0);
   x  = y - xu / xb;

   wqmpinv = x - (p - g(x)) / gp(x);

}
      return wqmpinv;
}
