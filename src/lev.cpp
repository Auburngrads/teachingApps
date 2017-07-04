#include <Rcpp.h>
#include <Rmath.h>
#include <math.h>
using namespace Rcpp;

//' The Largest Extreme Value Distribution
//' @description Density, distribution function, quantile function and 
//'              random generation for the LEV distribution with location
//'              \code{loc} and scale \code{scale}.
//' @export
//' @rdname lev
//' @param p Vector of probabilities
//' @param x, q Vector of quantiles
//' @param n Number of observations
//' @param loc Location parameter
//' @param scale Scale parameter
// [[Rcpp::export]]
NumericVector qlev(NumericVector p, 
                   const double loc = 0,
                   const double scale = 1) {
  
  return loc - scale * log(-log(p));
}

//' @export
//' @rdname lev
// [[Rcpp::export]]
NumericVector plev(NumericVector q, 
                   const double loc = 0,
                   const double scale = 1) {
  
  return exp(-exp(-(q - loc) / scale)); 
}

//' @export
//' @rdname lev
// [[Rcpp::export]]
NumericVector dlev(NumericVector x, 
                   const double loc = 0,
                   const double scale = 1) {
  
    NumericVector z = (x - loc) / scale;
    return (1/scale) * exp(-z - exp(-z));
}


//' @export
//' @rdname lev
// [[Rcpp::export]]
NumericVector rlev(const int n, 
                   const double loc = 0,
                   const double scale = 1) {
  
    return loc + scale * log(-log(runif(n)));
}
