// [[Rcpp::depends(BH)]]
// [[Rcpp::depends(RcppEigen)]]
// [[Rcpp::depends(RcppNumerical)]]
// [[Rcpp::plugins("cpp11")]]

#include <Rcpp.h>
#include <boost/math/special_functions/beta.hpp>
#include <RcppNumerical.h>
#include <boost/math/distributions/beta.hpp>
#include <boost/random.hpp>
#include <boost/random/uniform_real_distribution.hpp>

using namespace Rcpp;
using namespace boost::math;
using namespace boost::random;
using namespace Numer;

//' The Four Parameter Beta Distribution
//' 
//' @description Density, distribution function, quantile function and 
//'              random generation for the four parameter Beta distribution 
//'              with minimum value \code{min} and scale \code{scale}.
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
//' @return \code{dbeta4} gives the density, 
//'         \code{pbeta4} gives the distribution function, 
//'         \code{qbeta4} gives the quantile function, and 
//'         \code{rbeta4} generates random observations.
//'         
//'         The length of the result is determined by \code{n} 
//'         for \code{rbeta4}, and is the maximum of the lengths 
//'         of the numerical arguments for the other functions. 
//'         
//'         The numerical arguments other than \code{n} are 
//'         recycled to the length of the result.   
//'          
//' @source Birnbaum, Z. W.; Saunders, S. C. (1969), "A new family of life distributions", Journal of Applied Probability, 6 (2): 319–327, JSTOR 3212003, doi:10.2307/3212003
//' @export
//' @rdname beta4
//' @name Four Parameter Beta
//' @param p Vector of probabilities
//' @param x Vector of quantiles
//' @param q Vector of quantiles
//' @param n Number of observations
//' @param min The minumum value on which the distribution is defined
//' @param max The maximum value on which the distribution is defined
//' @param shape1 Shape parameter
//' @param shape2 Shape parameter
//' @param gap Spacing from \code{min} and \code{max}
//' @param seed A numeric value for the seed of the random number generator 
//' @export
// [[Rcpp::export]]
NumericVector dbeta4(NumericVector x,
                     double min,
                     double max,
                     double shape1,
                     double shape2,
                     double gap = 0) {
  
  double MIN = which_min(x);
  double MAX = which_max(x);
  
  bool test1 = x[MIN] < min ;
  
  if(test1==TRUE) { 
       stop("Values in x cannot be smaller than min");
  }
  
  bool test2 = x[MAX] > max ;
  
  if(test2==TRUE) {
       stop("Values in x cannot be greater than max");
  }
  
  bool test3 = x[MIN] == min ;
  
  if(test3==TRUE) { x[MIN] = x[MIN] + gap; }
  
  bool test4 = x[MAX] == max ;
  
  if(test4==TRUE) { x[MAX] = x[MAX] - gap; }
  
  NumericVector numer = pow((x - min), (shape1 - 1)) * pow((max - x), (shape2 - 1));
  double denom = pow((max - min), (shape1 + shape2 - 1));
  double beta  = boost::math::beta(shape1, shape2) ;

  return numer / (denom * beta) ;
}


class Ibeta: public Func
{
private:
  const double min;
  const double max;
  const double shape1;
  const double shape2 ;
public:
  Ibeta(double min_, 
        double max_, 
        double shape1_,
        double shape2_) : min(min_), max(max_), shape1(shape1_), shape2(shape2_) {}
  
  double operator()(const double& x) const
  {
    return pow((x-min), (shape1-1)) * pow((max - x), (shape2-1));
  }
};

//' @export
//' @rdname beta4
//' @import RcppNumerical
// [[Rcpp::export]]
NumericVector pbeta4(NumericVector q,
                     double min, 
                     double max,
                     double shape1,
                     double shape2,
                     double gap = 0)
{
  
  const int N = q.length();
  NumericVector  numer(N);
  
  int MIN = which_min(q);
  int MAX = which_max(q);

  bool test1 = q[MIN] < min ;

  if(test1==TRUE) {
      stop("Values in q cannot be smaller than min");
  }

  bool test2 = q[MAX] > max ;

  if(test2==TRUE) {
      stop("Values in q cannot be greater than max");
  }

  bool test3 = q[MIN] == min ;

  if(test3==TRUE) { q[MIN] = q[MIN] + gap; }

  bool test4 = q[MAX] == max ;
  
  if(test4==TRUE) { q[MAX] = q[MAX] - gap; }
  
  Ibeta f(min, max, shape1, shape2);
  double err_est;
  int err_code;
  
  for(int i = 0; i < N; i++) {
    
    numer[i] = integrate(f, min, q[i], err_est, err_code);
    
  }
  
  double denom = pow((max - min), (shape1 + shape2 - 1));
  double beta  = boost::math::beta(shape1, shape2) ;
  
  return numer / (denom * beta) ;
}

//' @export
//' @rdname beta4
// [[Rcpp::export]]
NumericVector qbeta4(NumericVector p,
                     double min, 
                     double max,
                     double shape1,
                     double shape2)
  {

  const int N = p.length();
  NumericVector  randFromDist(N);
  boost::math::beta_distribution<> dist(shape1, shape2);
  
  for(int i = 0; i < N; i++) {
    
    randFromDist[i] = quantile(dist, p[i]) * (max - min) + min;
    
  }

  return randFromDist;
  
  }

//' @export
//' @rdname beta4
// [[Rcpp::export]]
NumericVector rbeta4(int const n,
                     double min, 
                     double max,
                     double shape1,
                     double shape2,
                     double seed = 42)
{
  
  boost::mt19937 gen(seed);
  boost::math::beta_distribution<> dist(shape1, shape2);
  boost::random::uniform_real_distribution<double> boost_distrib(0, 1); 
  boost::variate_generator<boost::mt19937&,boost::random::uniform_real_distribution<double> > rng(gen, boost_distrib);
  
  NumericVector  randFromDist(n);
  double         randFromUnif;
  
  for(int i = 0; i < n; i++) {
    
    randFromUnif = rng();
    randFromDist[i] = quantile(dist, randFromUnif) * (max - min) + min;
    
  }
  
  return randFromDist;
  
}  