#include <Rcpp.h>
#include <Rmath.h>
#include <math.h>
using namespace Rcpp;

//' The Smallest Extreme Value Distribution
//' @description Density, distribution function, quantile function and 
//'              random generation for the SEV distribution with location
//'              \code{loc} and scale \code{scale}.
//'              
//' @details If \code{loc} is not specified, a default 
//'          value of 0 is used. If \code{scale} is not 
//'          specified, a default value of 1 is used.
//'          
//'          The smallest extreme value distribution with 
//'          location parameter \eqn{\mu} and
//'          scale \eqn{\sigma} has density
//'          
//'          \deqn{f(x;\mu,\sigma) = \frac{1}{\sigma}\phi_{_{SEV}}\left(\frac{x-\mu}{\sigma}\right),\quad -\infty < x < \infty }
//'          
//'          where \eqn{\phi_{_{SEV}}(z)} exp[z - exp(z)] is the density of the standard LEV distribution.
//'          
//' @return \code{dsev} gives the density, 
//'         \code{psev} gives the distribution function, 
//'         \code{qsev} gives the quantile function, and 
//'         \code{rsev} generates random observations.
//'         
//'         The length of the result is determined by \code{n} 
//'         for \code{rsev}, and is the maximum of the lengths 
//'         of the numerical arguments for the other functions. 
//'         
//'         The numerical arguments other than \code{n} are 
//'         recycled to the length of the result.   
//' @export
//' @rdname sev
//' @name Smallest Extreme Value
//' @param p Vector of probabilities
//' @param x Vector of quantiles
//' @param q Vector of quantiles
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
