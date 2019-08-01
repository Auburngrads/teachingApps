#include "heads/base.h"
#include <spmlgeng/gcdfml.h>

//' R interface for gng log(1-cdf)
//' @param tvec A numeric vector of observations
//' @param gamme A numeric matrix containing the parameter values
//' @param maxlen The number of columns in \code{gamme}
//' @param answer A numeric vector containing the return values
// [[Rcpp::export]]
Rcpp::NumericVector spmlgeng(Rcpp::NumericVector tvec,
                             Rcpp::NumericMatrix gamme,
                             int maxlen,
                             Rcpp::NumericVector answer){
  
for(int i = 0; i < maxlen; i++){
   
     answer.at(i) = gcdfml(tvec.at(i),gamme.column(i),9);
   
 }

       return answer;
  
}
