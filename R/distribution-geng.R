#' The Generalized Gamma Distribution
#'
#' @export
#' @rdname Generalized-Gamma

dgeng <-
function (x, theta, delta, varrho) 
{
    return(exp(dlgeng(x, theta, delta, varrho)))
}

#'
#'

dlgeng <-
  function (x, theta, delta, varrho) 
  {
    return(dlgengl(logb(x), theta, delta, varrho) - logb(x))
  }

#'
#'

dgengl <-
  function (y, theta, delta, varrho, smalldelta) 
  {
    return(exp(dlgengl(y, theta, delta, varrho)))
  }

#'
#'

dlgengl <-
  function (y, theta, delta, varrho) 
  {
    logphislg <- function(w, delta, smalldelta = 2e-05) {
      lognormal <- abs(delta) < smalldelta
      answer <- rep(NA, length(w))
      delta.ok <- delta[!lognormal]
      w.ok <- w[!lognormal]
      answer[!lognormal] <- logb(abs(delta.ok)) + (1/delta.ok^2) * 
        logb(1/delta.ok^2) - lgamma(1/delta.ok^2) + w.ok/(delta.ok) - 
        exp(delta.ok * w.ok)/delta.ok^2
      answer[lognormal] <- logb(dnorm(w[lognormal]))
      return(answer)
    }
    maxlen <- max(length(y), length(theta), length(delta), length(varrho))
    y <- expand.vec(y, maxlen)
    theta <- expand.vec(theta, maxlen)
    delta <- expand.vec(delta, maxlen)
    varrho <- expand.vec(varrho, maxlen)
    mu <- logb(theta) + varrho/delta * logb(1/delta^2)
    w <- (y - mu)/varrho
    answer <- logphislg(w, delta) - logb(varrho)
    return(answer)
  }

#'
#' @export
#' @rdname Generalized-Gamma

pgeng <-
  function (q, theta, delta, varrho) 
  {
    return(pgengl(logb(q), theta, delta, varrho))
  }

#'
#'

pgengl <-
  function (y, theta, delta, varrho) 
  {
    phibgng <- function(w, delta, smalldelta = 0.001) {
      answer <- rep(NA, length(w))
      lognormal <- abs(delta) < smalldelta
      negdelta <- delta < -smalldelta
      w.ok <- w[!lognormal]
      delta.ok <- delta[!lognormal]
      answer[!lognormal] <- pgamma((1/delta.ok^2) * exp(delta.ok * 
                                                          w.ok), (1/delta.ok^2))
      answer[negdelta] <- 1 - answer[negdelta]
      answer[lognormal] <- pnorm(w[lognormal])
      return(answer)
    }
    maxlen <- max(length(y), length(theta), length(delta), 
                  length(varrho))
    y <- expand.vec(y, maxlen)
    theta <- expand.vec(theta, maxlen)
    delta <- expand.vec(delta, maxlen)
    varrho <- expand.vec(varrho, maxlen)
    mu <- logb(theta) + varrho/delta * logb(1/delta^2)
    w <- (y - mu)/varrho
    answer <- phibgng(w, delta)
    return(answer)
  }

#' @export
#' @rdname Generalized-Gamma

qgeng <-
  function (p, theta, delta, varrho, smalldelta = 1e-05) 
  {
    return(exp(qgengl(p, theta, delta, varrho, smalldelta)))
  }

#'
#'

qgengl <-
  function (p, theta, delta, varrho, smalldelta = 1e-05) 
  {
    maxlen <- max(length(p), length(theta), length(delta), 
                  length(varrho))
    p <- expand.vec(p, maxlen)
    theta <- expand.vec(theta, maxlen)
    delta <- expand.vec(delta, maxlen)
    varrho <- expand.vec(varrho, maxlen)
    lognormal <- abs(delta) <= smalldelta
    posdelta <- delta > smalldelta
    negdelta <- delta < -smalldelta
    answer <- rep(NA, length(p))
    answer[posdelta] <- logb(qgamma(p[posdelta], 1/delta[posdelta]^2)^(1/delta[posdelta]))
    answer[negdelta] <- logb(qgamma(1 - p[negdelta], 1/delta[negdelta]^2)^(1/delta[negdelta]))
    answer[lognormal] <- qnorm(p[lognormal])
    return(logb(theta) + answer * varrho)
  }

#' @export
#' @rdname Generalized-Gamma

rgeng <-
  function (n, theta, delta, varrho) 
  {
    qgeng(runif(n), theta, delta, varrho)
  }

#'
#'

sgeng <-
  function (x, theta, delta, varrho, smalldelta = 1e-05) 
  {
    return(sgengl(logb(x), theta, delta, varrho, smalldelta))
  }

#'
#'

sgengl <-
  function (y, theta, delta, varrho, smalldelta = 1e-05) 
  {
    phiblg <- function(w, delta) {
      pgamma(w, (1/delta^2))
    }
    maxlen <- max(length(y), length(theta), length(delta), 
                  length(varrho))
    y <- expand.vec(y, maxlen)
    theta <- expand.vec(theta, maxlen)
    delta <- expand.vec(delta, maxlen)
    varrho <- expand.vec(varrho, maxlen)
    w <- rep(NA, length(y))
    answer <- rep(NA, length(y))
    lognormal <- abs(delta) < smalldelta
    mulognormal <- logb(theta[lognormal]) + (varrho[lognormal]/delta[lognormal]) * 
      logb(1/delta[lognormal]^2)
    answer[lognormal] <- pnorm((y[lognormal] - mulognormal)/varrho[lognormal])
    w <- (delta * (y - logb(theta)))/varrho
    posdelta <- delta > smalldelta
    answer[posdelta] <- 1 - phiblg(exp(w[posdelta]), delta[posdelta])
    negdelta <- delta < -smalldelta
    answer[negdelta] <- phiblg(exp(w[negdelta]), delta[negdelta])
    return(answer)
  }
