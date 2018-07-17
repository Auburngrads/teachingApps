generic.distribution <-
function (distribution, 
          allow = F)
{
  
    if(!is.character(distribution)){
      
        stop(paste("distribution must be character string:",
                    distribution))
      
    }
  
    distribution <- gsub(' '  , '', distribution)
    distribution <- gsub('-'  , '', distribution)
    distribution <- gsub('_'  , '', distribution)
  
    switch(tolower(distribution), 
           uniform       = { distribution <- "uniform" },
           unif          = { distribution <- "uniform" },
           loguniform    = { distribution <- "loguniform" },
           logunif       = { distribution <- "loguniform" },
           exponential   = { distribution <- "exponential" }, 
           exp           = { distribution <- "exponential" },
           smallestextremevalue = { distribution <- "sev" }, 
           sev                  = { distribution <- "sev" }, 
           logsev  = { distribution <- "weibull" }, 
           weibull = { distribution <- "weibull" },
           weib    = { distribution <- "weibull" },
           nor     = { distribution <- "normal" }, 
           normal  = { distribution <- "normal" }, 
           norm    = { distribution <- "normal" },
           lognormal       = { distribution <- "lognormal" }, 
           lognormal.basee = { distribution <- "lognormal" },
           lnorm           = { distribution <- "lognormal" },
           lognormal10      = { distribution <- "lognormal10" }, 
           lognormal.base10 = { distribution <- "lognormal10" },
           lnorm10          = { distribution <- "lognormal10" },
           loglogis    = { distribution <- "loglogistic" }, 
           loglogistic = { distribution <- "loglogistic" }, 
           logis    = { distribution <- "logistic" }, 
           logistic = { distribution <- "logistic" }, 
           largestextremevalue     = { distribution <- "lev" }, 
           lev                     = { distribution <- "lev" }, 
           gamma = { distribution <- "gamma" }, 
           igau            = { distribution <- "igau" }, 
           inversegaussian = { distribution <- "igau" }, 
           bisa             = { distribution <- "bisa" }, 
           birnbaumsaunders = { distribution <- "bisa" }, 
           goma            = { distribution <- "goma" }, 
           gompertzmakeham = { distribution <- "goma" }, 
           generalizedgamma = { distribution <- "gng" }, 
           gng              = { distribution <- "gng" }, 
           generalizedf = { distribution <- "gnf" }, 
           gnf          = { distribution <- "gnf" }, 
           logextendedgeneralizedgamma = { distribution <- "egengl" }, 
           egengl                      = { distribution <- "egengl" }, 
           extendedgeneralizedgamma = { distribution <- "egeng" }, 
           egeng                    = { distribution <- "egeng" }, 
           reciprocalweibull = { distribution <- "frechet" }, 
           frechet           = { distribution <- "frechet" }, 
           loglev            = { distribution <- "frechet" }, 
           recipweibull      = { distribution <- "frechet" }, 
           sevgeneralizedthresholdscale = { distribution <- "sevgets" }, 
           sevgets                      = { distribution <- "sevgets" }, 
           levgeneralizedthresholdscale = { distribution <- "levgets" }, 
           levgets                      = { distribution <- "levgets" }, 
           normalgeneralizedthresholdscale = { distribution <- "normalgets" }, 
           norgets                         = { distribution <- "normalgets" }, 
           normalgets                      = { distribution <- "normalgets" }, 
           beta    = { distribution <- "beta" }, 
           logbeta = { distribution <- "logbeta" }, 
           triangle    = { distribution <- "triangle" }, 
           logtriangle = { distribution <- "logtriangle" }, 
           xdummy = { distribution <- "xdummy" }, 
           
           { 
             
             `if`(allow,
                  return(NULL),
                  stop(paste(distribution, "is an unrecognized distribution in generic.distribution()")))
             
           })
  
    return(distribution)
}
