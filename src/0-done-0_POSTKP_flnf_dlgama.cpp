#include "heads/base.h"
#include "heads/constants.hpp"
using namespace constants;

//' Calculate the log(gamma) function for a real argument
//' 
//' Computation is based on an algorithm outlined in 
//' references 1 and 2.  The program uses rational 
//' functions that approximate log(gamma) to at least 
//' 18 significant decimal digits.  The approximation 
//' for x >= 12 is from reference 3.  Approximations
//' for x < 12.0 are unpublished.  Lower order 
//' approximations can be substituted on machines with 
//' less precise arithmetic.
//'
//'
//' Explanation of machine-dependent constants
//'
//' xbig   - the largest argument for which ln(gamma(x)) is representable
//'          in the machine, i.e., the solution to the equation
//'                  ln(gamma(xbig)) = xinf.
//' xinf   - the largest machine representable floating-point number.
//' eps    - the smallest positive floating-point number such that
//'          1.0+eps .gt. 1.0
//' frtbig - rough estimate of the fourth root of xbig
//'
//'     approximate values for some important machines are:
//'
//'          ibm/370   cdc/7600   univac/110x      vax 11/780
//'           (d.p.)  (s.p.,rndg)    (d.p.)      (s.p.)     (d.p.)
//'
//' xbig    4.293d+73  1.716e+319  1.280d+305  2.057e+36  2.057d+36
//' xinf    7.230d+75  1.260e+322  8.980d+307  1.701e+38  1.701d+38
//' eps     2.220d-16  3.550e-015  1.735d-018  5.960e-08  1.388d-17
//' frtbig  2.500d+18  6.400e+079  1.800d+076  1.100e+09  1.100d+09
//'
//'
//' error returns
//'
//'  the program returns the value xinf for singularities or
//'     when overflow would occur.  the computation is believed
//'     to be free of underflow and overflow.
//'
//'
//' other subprograms required (single precision version)
//'
//'      alog,exp,float,ifix,sin
//'
//' other subprograms required (double precision version)
//'
//'     dble,dexp,dlog,dsin,float,ifix,sngl
//'
//'
//' References:
//'
//'  1) w. j. cody and k. e. hillstrom, 'chebyshev approximations for
//'     the natural logarithm of the gamma function,' math. comp. 21,
//'     1967, pp. 198-203.
//'
//'  2) k. e. hillstrom, anl/amd program anlc366s, dgamma/dlgama, may,
//'     1969.
//'
//'  3) hart, et. al., computer approximations, wiley and sons, new
//'     york, 1968.
//'
//'
//'  author: w. j. cody
//'          argonne national  laboratory
//'
//'  latest modification: july 14, 1983

double dlgama(double x){

double corr,eps = 1.388e-17,frtbig = 1.1e9,pnt68 = 0.6796875e0;
double res,thrhal = 1.5e0,xbig = 2.057e36,xden;
double xinf = 1.701e38,xm1,xm2,xm4,xnum,y,ysq;
Rcpp::NumericVector c, p1, p2, p4, q1, q2, q4;

//----------------------------------------------------------------------
//  numerator and denominator coefficients for rational minimax
//     approximation over (0.5,1.5).
//----------------------------------------------------------------------
double d1 = -5.772156649015328605195174e-1;

p1 = NumericVector::create(4.945235359296727046734888e0,
                           2.018112620856775083915565e2,
                           2.290838373831346393026739e3,
                           1.131967205903380828685045e4,
                           2.855724635671635335736389e4,
                           3.848496228443793359990269e4,
                           2.637748787624195437963534e4,
                           7.225813979700288197698961e3);
q1 = NumericVector::create(6.748212550303777196073036e1,
                           1.113332393857199323513008e3,
                           7.738757056935398733233834e3,
                           2.763987074403340708898585e4,
                           5.499310206226157329794414e4,
                           6.161122180066002127833352e4,
                           3.635127591501940507276287e4,
                           8.785536302431013170870835e3);
//----------------------------------------------------------------------
//  numerator and denominator coefficients for rational minimax
//     approximation over (1.5,4.0).
//----------------------------------------------------------------------
double d2 = 4.227843350984671393993777e-1;

p2 = NumericVector::create(4.974607845568932035012064e0,
                           5.424138599891070494101986e2,
                           1.550693864978364947665077e4,
                           1.847932904445632425417223e5,
                           1.088204769468828767498470e6,
                           3.338152967987029735917223e6,
                           5.106661678927352456275255e6,
                           3.074109054850539556250927e6);
q2 = NumericVector::create(1.830328399370592604055942e2,
                           7.765049321445005871323047e3,
                           1.331903827966074194402448e5,
                           1.136705821321969608938755e6,
                           5.267964117437946917577538e6,
                           1.346701454311101692290052e7,
                           1.782736530353274213975932e7,
                           9.533095591844353613395747e6);
//----------------------------------------------------------------------
//  numerator and denominator coefficients for rational minimax
//     approximation over (4.0,12.0).
//----------------------------------------------------------------------
double d4 = 1.791759469228055000094023e0;

p4 = NumericVector::create(1.474502166059939948905062e4,
                           2.426813369486704502836312e6,
                           1.214755574045093227939592e8,
                           2.663432449630976949898078e9,
                           2.940378956634553899906876e10,
                           1.702665737765398868392998e11,
                           4.926125793377430887588120e11,
                           5.606251856223951465078242e11);
q4 = NumericVector::create(2.690530175870899333379843e3,
                           6.393885654300092398984238e5,
                           4.135599930241388052042842e7,
                           1.120872109616147941376570e9,
                           1.488613728678813811542398e10,
                           1.016803586272438228077304e11,
                           3.417476345507377132798597e11,
                           4.463158187419713286462081e11);
//----------------------------------------------------------------------
//  coefficients for minimax approximation over (12, inf).
//----------------------------------------------------------------------
c = NumericVector::create(-1.910444077728e-03,
                          8.4171387781295e-04,
                          -5.952379913043012e-04,
                          7.93650793500350248e-04,
                          -2.777777777777681622553e-03,
                          8.333333333333333331554247e-02,
                          5.7083835261e-03);
//----------------------------------------------------------------------
      y = x;
      if((y <= zero) or (y > xbig)) goto line700;
      if(y > twelve)  goto line400;
      if(y > four)    goto line300;
      if(y > thrhal)  goto line200;
      if(y >= pnt68)  goto line100;
      corr = -log(y);
      xm1 = y;
      if(y > eps) goto line120;
      res = corr;
      goto line900;
//----------------------------------------------------------------------
//  0.5 .lt. x .le. 1.5
//----------------------------------------------------------------------
line100: corr = zero;
         xm1 = (y - half) - half;
line120: xden = one;
         xnum = zero;
      
      for(int i = 0; i < 8; i++){
        
          xnum = xnum * xm1 + p1.at(i);
          xden = xden * xm1 + q1.at(i);
        
      }
      res = corr + (xm1 * (d1 + xm1 * (xnum / xden)));
      goto line900;
//----------------------------------------------------------------------
//  1.5 .lt. x .le. 4.0
//----------------------------------------------------------------------
line200: xm2 = y - two;
         xden = one;
         xnum = zero;
      
      for(int i = 0; i < 8; i++){
        
          xnum = xnum * xm2 + p2.at(i);
          xden = xden * xm2 + q2.at(i);
        
      }
      res = xm2 * (d2 + xm2 * (xnum / xden));
      goto line900;
//----------------------------------------------------------------------
//  4.0 .lt. x .le. 12.0
//----------------------------------------------------------------------
line300: xm4 = y - four;
         xden = -one;
         xnum = zero;
      
      for(int i = 0; i < 8; i++){
        
         xnum = xnum * xm4 + p4.at(i);
         xden = xden * xm4 + q4.at(i);
         
      }
      res = d4 + xm4 * (xnum / xden);
      goto line900;
//----------------------------------------------------------------------
//  evaluate for argument .ge. 12.0,
//----------------------------------------------------------------------
line400: res = zero;
         if(y > frtbig) goto line460;
         res = c.at(6);
         ysq = y * y;
      
      for(int i = 0; i < 6; i++){
        
         res = res / ysq + c.at(i);
        
      }
line460: res = res / y;
         corr = log(y);
         res = res + sqrtpi - half * corr;
         res = res + y * (corr - one);
         goto line900;
//----------------------------------------------------------------------
//  return for bad arguments
//----------------------------------------------------------------------
line700: res = xinf;
//----------------------------------------------------------------------
//  final adjustments and return
//----------------------------------------------------------------------
line900: return res;
  
}