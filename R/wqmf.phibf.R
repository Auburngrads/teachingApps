wqmf.phibf <-
function (z, distribution) 
{
    switch(generic.distribution(distribution), 
           uniform     = { pvec <- z },
           weibull     = { pvec <- 1 - exp(-exp(z)) }, 
           sev         = { pvec <- 1 - exp(-exp(z)) }, 
           frechet     = { pvec <- exp(-exp(-z)) }, 
           lev         = { pvec <- exp(-exp(-z)) },  
           normal      = { pvec <- pnorm(z) }, 
           lognormal   = { pvec <- pnorm(z) }, 
           loglogistic = { pvec <- plogis(z) }, 
           logistic    = { pvec <- plogis(z) }, 
           exponential = { pvec <- pexp(z) }, 
           
           { 
             
             stop(paste(distribution, "is not a recognized distribution"))
             
           })    
  
  return(pvec)
  
}
