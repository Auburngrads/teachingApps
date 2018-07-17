#include "heads/base.h"
#include <sgquan/gquant.h>

//' R interface for GENG cdf
//' 
//' @name sgquan

// [[Rcpp::export]]
Rcpp::NumericVector sgquan(Rcpp::NumericVector pvec,
                           Rcpp::NumericMatrix gamme,
                           int maxlen,
                           Rcpp::NumericVector answer){

for(int i = 0; i < maxlen; i++){

    answer.at(i) = gquant(pvec.at(i),gamme.column(i),9);

}

    return answer;
  
}


/***R
library(SMRD)
p <- c(1:100)/100
mu  = 10.5
sigma = 0.25
# delta is a key value 
# good for delta = 0 and delta = 1
# issues start creeping in for delta > 1
delta = .5
smalldelta = 0.001 

  maxlen <- max(length(p), length(mu), length(delta), length(sigma))
  p     <- SMRD:::expand.vec(p, maxlen)
  mu   <- SMRD:::expand.vec(mu, maxlen)
  sigma <- SMRD:::expand.vec(sigma, maxlen)
  delta <- SMRD:::expand.vec(delta, maxlen)
  logsigma <- logb(sigma)
  xk <- rep(0, maxlen)
  sqrtxk <- rep(0, maxlen)
  logxk <- rep(0, maxlen)
  lgamxk <- rep(0, maxlen)
  lognormal <- abs(delta) <= smalldelta
  delta[lognormal] <- 0
  xk[!lognormal] <- 1/delta[!lognormal]^2
  sqrtxk[!lognormal] <- sqrt(xk[!lognormal])
  logxk[!lognormal] <- logb(xk[!lognormal])
  lgamxk[!lognormal] <- lgamma(xk[!lognormal])
  gammemat <- rbind(mu, sigma, logsigma, delta, xk, sqrtxk, 
                    logxk, lgamxk)
  zout <- .Fortran("sgquan", as.double(p), as.double(gammemat), 
                   as.integer(maxlen), answer = double(maxlen))
  
new <- smrdcpp:::sgquan(as.double(p), 
                        as.matrix(gammemat), 
                        as.integer(maxlen), 
                        answer = double(maxlen))

zout$answer - new
plot(x = p, y = new)
*/
