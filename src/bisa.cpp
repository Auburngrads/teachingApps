#include <Rcpp.h>
using namespace Rcpp;

//' The Birmbaum-Saunders Distribution
//' @description Density, distribution function, quantile function and 
//'              random generation for the BISA distribution with location
//'              \code{loc} and scale \code{scale}.
//' @export
//' @rdname bisa
//' @param p Vector of probabilities
//' @param x, q Vector of quantiles
//' @param n Number of observations
//' @param shape Shape parameter
//' @param scale Scale parameter
// [[Rcpp::export]]
NumericVector qbisa(NumericVector p, 
                    const double shape,
                    const double scale = 1) {
  
  NumericVector qn(p);
  
  qn = qnorm(p); 
  
  return scale * pow((shape * qn + sqrt(4 + pow(shape * qn, 2))) / 2, 2);
}

//' @export
//' @rdname bisa
// [[Rcpp::export]]
NumericVector pbisa(NumericVector q, 
                    const double shape,
                    const double scale = 1) {
  
  NumericVector   z(q);
  
  z = log(q / scale);
  
  return pnorm((exp(z / 2) - exp(-z / 2)) / shape);
  
}


// [[Rcpp::export]]
NumericVector dlbisa(NumericVector z, 
                     const double shape) {
  
  const int N = z.length();
  NumericVector  z1(N);
  NumericVector top(N);
  const double   bot = 2 * shape;
  NumericVector dlb(N);
  
  for(int i = 0; i < N; i++) {
    
  top[i] =  exp(z[i] / 2) + exp(-z[i] / 2)  / bot;
  z1[i]  = (exp(z[i] / 2) - exp(-z[i] / 2)) / shape;
  
  }
  dlb = dnorm(z1) * top;
    
  return dlb;
  
}


//' @export
//' @rdname bisa
// [[Rcpp::export]]
NumericVector dbisa(NumericVector x, 
                    const double shape,
                    const double scale = 1) {
  
  NumericVector z(x);
  
  z = dlbisa(log(x / scale), shape);
  
  return (z / x);
  
}


//' @export
//' @rdname bisa
// [[Rcpp::export]]
NumericVector rbisa(const int n, 
                    const double shape,
                    const double scale = 1) {
  
  NumericVector x(n);
  double z;
  
  for (int i = 0; i < n; i++) {
    
       z = R::norm_rand();
    x[i] = pow(shape / 2 * z + sqrt(pow(shape / 2 * z, 2) + 1), 2) * scale;
    
  }
     
    return x;
}
