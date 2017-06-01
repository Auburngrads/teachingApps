#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
LogicalVector likely2(NumericVector times,
                      NumericVector cens,
                      NumericVector params,
                      const double maxll) 
{
  const int N = params.length();
  NumericVector fails(N)   ;
  NumericVector right(N)   ;
  NumericVector loglike(N) ;
  double logie = 0 ;
  NumericVector rellike(N) ;
  NumericVector compare = runif(N) ;
  LogicalVector keep(N) ;
  
  for(int i = 0; i < N; i++) {

  fails = cens * log(1 / params[i] * exp(-times / params[i])) ;
  
  right = (1 - cens) * -times / params[i] ;
  
  logie = sum(fails + right);
    
  loglike[i] = (logie) ;
  
  }
  
  rellike = exp(loglike) / exp(maxll) ;
  keep = rellike > compare ;
  return keep;  
}