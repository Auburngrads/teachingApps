#include <Rcpp.h>
using namespace Rcpp;

//' The Birmbaum-Saunders Distribution
//' 
//' @description Density, distribution function, quantile function and 
//'              random generation for the BISA distribution with location
//'              \code{loc} and scale \code{scale}.
//'              
//' @details If \code{shape} is not specified, a default 
//'          value of 1 is used.
//'          
//'          The Birmbaum-Saunders distribution with shape \eqn{\beta} and
//'          scale \eqn{\theta} has density
//'          
//'          \deqn{f(x;\theta,\beta) = \frac{\sqrt{\frac{x}{\theta}}+\sqrt{\frac{\theta}{x}}}{2\beta x}\phi_{_{NOR}(z)},\quad x \ge 0 }
//'          
//'          where \eqn{\phi_{_{NOR}}(z)} is the density of the standard normal distribution and  
//'          
//'          \deqn{z = \frac{1}{\beta}\left(\sqrt{\frac{x}{\theta}}-\sqrt{\frac{\theta}{x} } \right)}.
//'          
//' @return \code{dbisa} gives the density, 
//'         \code{pbisa} gives the distribution function, 
//'         \code{qbisa} gives the quantile function, and 
//'         \code{rbisa} generates random observations.
//'         
//'         The length of the result is determined by \code{n} 
//'         for \code{rbisa}, and is the maximum of the lengths 
//'         of the numerical arguments for the other functions. 
//'         
//'         The numerical arguments other than \code{n} are 
//'         recycled to the length of the result.   
//'          
//' @source Birnbaum, Z. W.; Saunders, S. C. (1969), "A new family of life distributions", Journal of Applied Probability, 6 (2): 319–327, JSTOR 3212003, doi:10.2307/3212003
//' @export
//' @rdname bisa
//' @name Birmbaum-Saunders
//' @param p Vector of probabilities
//' @param x Vector of quantiles
//' @param q Vector of quantiles
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
