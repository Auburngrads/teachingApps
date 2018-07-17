wqmf.phisl <-
function (z, distribution) 
{
    switch(basic.distribution(distribution), 
           
           sev      = { p <- z - exp(z)      }, 
           normal   = { p <- logb(dnorm(z))  }, 
           logistic = { p <- logb(dlogis(z)) }, 
           lev      = { p <- -z - exp(-z)    }, 
           
           { 
             
             stop(paste(distribution, "is not a recognized distribution"))
             
           })
  
    return(p)
}
