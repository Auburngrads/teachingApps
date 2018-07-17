#include "heads/base.h"
#include <spmlgeng/gcdfml.h>

//' R interface for gng log(1-cdf)

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
