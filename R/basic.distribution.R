basic.distribution <-
function (distribution) 
{
    switch.dist <- generic.distribution(distribution)
    switch(switch.dist, exponential = , sev = , weibull = {
        ret.distribution <- "sev"
    }, lev = , frechet = {
        ret.distribution <- "lev"
    }, normal = , lognormal = {
        ret.distribution <- "normal"
    }, loglogistic = , logistic = {
        ret.distribution <- "logistic"
    }, {
        stop(paste("Distribution", distribution, switch.dist, 
            "not recognized"))
    })
    return(ret.distribution)
}
