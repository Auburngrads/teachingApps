#include <Rcpp.h>
#include <Rmath.h>
#include <math.h>
using namespace Rcpp;

//' The Smallest Extreme Value Distribution
//' @description Density, distribution function, quantile function and 
//'              random generation for the SEV distribution with location
//'              \code{loc} and scale \code{scale}.
//' @export
//' @rdname sev
//' @param p Vector of probabilities
//' @param x, q Vector of quantiles
//' @param n Number of observations
//' @param loc Location parameter
//' @param scale Scale parameter
// [[Rcpp::export]]
NumericVector qsev(NumericVector p, 
                   const double loc = 0,
                   const double scale = 1) {
  
  return loc + scale * log(-log(1 - p));
}

//' @export
//' @rdname sev
// [[Rcpp::export]]
NumericVector psev(NumericVector q, 
                   const double loc = 0,
                   const double scale = 1) {
  
  return 1 - exp(-exp((q - loc) / scale));
}

//' @export
//' @rdname sev
// [[Rcpp::export]]
NumericVector dsev(NumericVector x, 
                   const double loc = 0,
                   const double scale = 1) {
  
    NumericVector z = (x - loc) / scale;
    return (1/scale) * exp(z - exp(z));
}

//' @export
//' @rdname sev
// [[Rcpp::export]]
NumericVector rsev(const int n, 
                   const double loc = 0,
                   const double scale = 1) {
  
    return loc + scale * log(-log(1 - runif(n)));
}
