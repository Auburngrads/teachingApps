#' The Extended Generalized Gamma Distribution
#'
#' @export
#' @rdname Extended-Generalized-Gamma

degengl <-
function (x, mu, sigma, delta) 
{
    return(exp(dlegengl(x, mu, sigma, delta)))
}

#'
#'

dlegengl <-
  function (x, xmu, sigma, delta, smalldelta = 0.001) 
  {
    maxlen <- max(length(x), length(xmu), length(delta), length(sigma))
    x <- expand.vec(x, maxlen)
    xmu <- expand.vec(xmu, maxlen)
    sigma <- expand.vec(sigma, maxlen)
    delta <- expand.vec(delta, maxlen)
    logsigma <- logb(sigma)
    xk <- rep(0, maxlen)
    sqrtxk <- rep(0, maxlen)
    logxk <- rep(0, maxlen)
    lgamxk <- rep(0, maxlen)
    lognormal <- abs(delta) <= smalldelta
    frac <- abs(delta[lognormal])/smalldelta
    delta[lognormal] <- smalldelta * sign(delta)
    delta[frac < smalldelta] <- smalldelta
    xk <- 1/delta^2
    sqrtxk <- sqrt(xk)
    logxk <- logb(xk)
    lgamxk <- lgamma(xk)
    gammemat <- rbind(xmu, 
                      sigma, 
                      logsigma, 
                      delta, 
                      xk, 
                      sqrtxk, 
                      logxk, 
                      lgamxk)
    
    zout <- sgpdfl(as.double(x), 
                   as.double(gammemat), 
                   as.integer(maxlen), 
                   answer = double(maxlen))
    
    answer <- zout$answer
    answer[lognormal] <- frac * answer[lognormal] + (1 - frac) * 
      logb(dnorm(x[lognormal], xmu[lognormal], sigma[lognormal]))
    return(answer)
  }

#' @export
#' @rdname Extended-Generalized-Gamma

pegeng <-
  function (q, mu, sigma, delta, distribution = NULL) 
  {
    return(pegengl(logb(q), mu, sigma, delta))
  }

#'
#'

pegengl <-
  function (q, mu, sigma, delta, distribution = "dummy", smalldelta = 1e-04) 
  {
    distdummy <- distribution
    maxlen <- max(length(q), length(mu), length(delta), length(sigma))
    q <- expand.vec(q, maxlen)
    mu <- expand.vec(mu, maxlen)
    delta <- expand.vec(delta, maxlen)
    sigma <- expand.vec(sigma, maxlen)
    logsigma <- logb(sigma)
    xk <- rep(0, maxlen)
    sqrtxk <- rep(0, maxlen)
    logxk <- rep(0, maxlen)
    lgamxk <- rep(0, maxlen)
    lognormal <- abs(delta) <= smalldelta
    frac <- abs(delta[lognormal])/smalldelta
    delta[lognormal] <- smalldelta * sign(delta)
    delta[frac < smalldelta] <- smalldelta
    xk <- 1/delta^2
    sqrtxk <- sqrt(xk)
    logxk <- logb(xk)
    lgamxk <- lgamma(xk)
    
    gammemat <- rbind(mu, 
                      sigma, 
                      logsigma, 
                      delta, 
                      xk, 
                      sqrtxk, 
                      logxk, 
                      lgamxk)
    
    zout <- spgeng(as.double(q), 
                   as.double(gammemat),
                   as.integer(maxlen), 
                   answer = double(maxlen))
    
    answer <- zout$answer
    answer[lognormal] <- frac * answer[lognormal] + (1 - frac) * 
      pnorm(q[lognormal], mu[lognormal], sigma[lognormal])
    
    return(answer)
    
  }

#'
#'

pdlegeng <-
  function (z, mu, sigma, delta) 
  {
    prob.diff1 <- pegengl(z[, 2], mu, sigma, delta) - pegengl(z[, 
                                                                1], mu, sigma, delta)
    small <- prob.diff1 < 1e-05
    width <- z[, 2] - z[, 1]
    y2 <- degengl(z[, 2], mu, sigma, delta)
    y1 <- degengl(z[, 1], mu, sigma, delta)
    prob.diff2 <- (width * (y2 + y1))/2
    prob.diff1[small] <- prob.diff2[small]
    return(logb(prob.diff1))
  }

#' @export
#' @rdname Extended-Generalized-Gamma

qegengl <-
  function (p, mu, sigma, delta, distribution = NULL, smalldelta = 1e-04) 
  {
    maxlen <- max(length(p), length(mu), length(delta), length(sigma))
    p <- expand.vec(p, maxlen)
    mu <- expand.vec(mu, maxlen)
    delta <- expand.vec(delta, maxlen)
    sigma <- expand.vec(sigma, maxlen)
    logsigma <- logb(sigma)
    xk <- rep(0, maxlen)
    sqrtxk <- rep(0, maxlen)
    logxk <- rep(0, maxlen)
    lgamxk <- rep(0, maxlen)
    lognormal <- abs(delta) <= smalldelta
    delta[lognormal] <- 0
    xk[!lognormal] <- 1/delta[!lognormal]^2
    sqrtxk[!lognormal] <- sqrt(xk[!lognormal])
    logxk[!lognormal] <- logb(xk[!lognormal])
    lgamxk[!lognormal] <- lgamma(xk[!lognormal])
    
    gammemat <- rbind(mu, 
                      sigma, 
                      logsigma, 
                      delta, 
                      xk, 
                      sqrtxk, 
                      logxk, 
                      lgamxk)
    
    zout <- sgquan(as.double(p), 
                   as.double(gammemat), 
                   as.integer(maxlen), 
                   answer = double(maxlen))
    
    
    return(zout$answer)
    
  }

#'
#'

segengl <-
  function (x, mu, sigma, delta, smalldelta = 1e-04) 
  {
    maxlen <- max(length(x), length(mu), length(delta), length(sigma))
    x <- expand.vec(x, maxlen)
    mu <- expand.vec(mu, maxlen)
    sigma <- expand.vec(sigma, maxlen)
    delta <- expand.vec(delta, maxlen)
    logsigma <- logb(sigma)
    xk <- rep(0, maxlen)
    sqrtxk <- rep(0, maxlen)
    logxk <- rep(0, maxlen)
    lgamxk <- rep(0, maxlen)
    lognormal <- abs(delta) <= smalldelta
    frac <- abs(delta[lognormal])/smalldelta
    delta[lognormal] <- smalldelta * sign(delta)
    delta[frac < smalldelta] <- smalldelta
    xk <- 1/delta^2
    sqrtxk <- sqrt(xk)
    logxk <- logb(xk)
    lgamxk <- lgamma(xk)
    
    gammemat <- rbind(mu, 
                      sigma, 
                      logsigma, 
                      delta, 
                      xk, 
                      sqrtxk, 
                      logxk, 
                      lgamxk)
    
    zout <- spmlgeng(as.double(x), 
                     as.double(gammemat), 
                     as.integer(maxlen), 
                     answer = double(maxlen))
    
    answer <- zout$answer
    answer[lognormal] <- frac * answer[lognormal] + (1 - frac) * 
      logb(pnorm(-x[lognormal], -mu[lognormal], sigma[lognormal]))
    
    return(answer)
    
  }
