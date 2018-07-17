#include "heads/base.h"
#include <sgpdfl/gpdfl.h>

//' R interface for GENG cdf;
//' @name sgpdfl

// [[Rcpp::export]]
Rcpp::NumericVector sgpdfl(Rcpp::NumericVector tvec,
                           Rcpp::NumericMatrix gamme,
                           int maxlen,
                           Rcpp::NumericVector answer){

for(int i = 0; i < maxlen; i++){

    answer.at(i) = gpdfl(tvec.at(i),gamme.column(i),9);

}

    return answer;
  
}


/***R
library(SMRD)
x <- c(1:10)
xmu  = -1.5
sigma = 0.5
delta = 0.01
smalldelta = 0.001 
old_way = T

  maxlen <- max(length(x), length(xmu), length(delta), length(sigma))
  x     <- SMRD:::expand.vec(x, maxlen)
  xmu   <- SMRD:::expand.vec(xmu, maxlen)
  sigma <- SMRD:::expand.vec(sigma, maxlen)
  delta <- SMRD:::expand.vec(delta, maxlen)
  logsigma <- logb(sigma)
  xk <- rep(0, maxlen)
  sqrtxk <- rep(0, maxlen)
  logxk <- rep(0, maxlen)
  lgamxk <- rep(0, maxlen)
  lognormal <- abs(delta) <= smalldelta
  frac <- abs(delta[lognormal])/smalldelta

if(old_way) {
  
  delta[lognormal] <- smalldelta * sign(delta)
  delta[frac < smalldelta] <- smalldelta
  xk <- 1/delta^2
  sqrtxk <- sqrt(xk)
  logxk <- logb(xk)
  lgamxk<- lgamma(xk)
  
} else {
  
  delta[lognormal] <- 0
  xk[!lognormal] <- 1/delta[!lognormal]^2
  sqrtxk[!lognormal] <- sqrt(xk[!lognormal])
  logxk[!lognormal] <- logb(xk[!lognormal])
  lgamxk[!lognormal] <- lgamma(xk[!lognormal])
  
}
  gammemat <- rbind(xmu, sigma, logsigma, delta, xk, sqrtxk, 
                    logxk, lgamxk)
  zout <- .Fortran("sgpdfl", as.double(x), as.double(gammemat), 
                   as.integer(maxlen), answer = double(maxlen))

new <- smrdcpp:::sgpdfl(as.double(x), 
                        as.matrix(gammemat), 
                        as.integer(maxlen), 
                        answer = double(maxlen))

answer <- zout$answer
answer[lognormal] <- frac * answer[lognormal] + (1 - frac) * 
  logb(dnorm(x[lognormal], xmu[lognormal], sigma[lognormal]))

Answer <- new
Answer[lognormal] <- frac * Answer[lognormal] + (1 - frac) * 
  logb(dnorm(x[lognormal], xmu[lognormal], sigma[lognormal]))
  

exp(answer) - exp(Answer)
*/
