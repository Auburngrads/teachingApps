#' The Generalized Threshold Distribution 
#'
#' @description Compute values for members of the generalized threshold 
#'              distribution family. Members include distributions based
#'              on the normal distribution ("nor-gets"), the smallest-
#'              extreme value distribution ("sev-gets"), and the largest-
#'              extreme value distribution ("lev-gets").
#'
#' @param x The x
#' @param p The p
#' @param q The q
#' @param alpha The alpha
#' @param sigma The sigma
#' @param varzeta The varzeta
#' @param distribution The distribution on which the gets values are based
#'                     Either 'normal', 'lev', or 'sev' 
#' @param smallsigma The small sigma value
#'
#' @rdname gets
#' @export
dgets <-
function (x, 
          alpha, 
          sigma, 
          varzeta, 
          distribution, 
          smallsigma = 2e-05) 
{
    return(exp(dlgets(x, 
                      alpha, 
                      sigma, 
                      varzeta, 
                      distribution, 
                      smallsigma)))
  
}

dlgets <-
function (x, 
          alpha, 
          sigma, 
          varzeta, 
          distribution, 
          smallsigma = 2e-05) 
{
  
    maxlen <- max(length(x), 
                  length(alpha), 
                  length(sigma), 
                  length(varzeta))
    
    x       <- expand.vec(x, maxlen)
    alpha   <- expand.vec(alpha, maxlen)
    sigma   <- expand.vec(sigma, maxlen)
    varzeta <- expand.vec(varzeta, maxlen)
    
    z <- rep(NA, length(x))
    answer <- rep(NA, length(x))
    locscale <- abs(sigma) < smallsigma
    
    z <- (x - alpha)/varzeta
    
    possigma <- sigma > smallsigma & z > -1/sigma
    negsigma <- sigma < -smallsigma & z < -1/sigma
    answerzero.right <- sigma > smallsigma & z < -1/sigma
    answerzero.left <- sigma < -smallsigma & z > -1/sigma
    
    if (any(!locscale)) {
      
      onepsigz <- 1 + sigma[!locscale] * z[!locscale]
      positive.onepsigz <- onepsigz > 0
      logonepsigz <- rep(-Inf, length(onepsigz))
      logonepsigz[positive.onepsigz] <- logb(onepsigz[positive.onepsigz])
      the.arg <- logonepsigz / abs(sigma[!locscale])
      answer[!locscale] <- wqmf.phisl(the.arg, distribution) - 
        logonepsigz - logb(varzeta[!locscale])
      
    }
    answer[locscale] <- wqmf.phisl(z[locscale], distribution) - 
      logb(varzeta[locscale])
    answer[answerzero.right] <- -Inf
    answer[answerzero.left] <- -Inf
    
    return(answer)
  }

#' @rdname gets
#' @export

pgets <-
  function (q, 
            alpha, 
            sigma, 
            varzeta, 
            distribution, 
            smallsigma = 2e-05) 
    
{
    maxlen <- max(length(q), 
                  length(alpha), 
                  length(sigma), 
                  length(varzeta))
    
    q       <- expand.vec(q, maxlen)
    alpha   <- expand.vec(alpha, maxlen)
    sigma   <- expand.vec(sigma, maxlen)
    varzeta <- expand.vec(varzeta, maxlen)
    z <- rep(NA, length(q))
    answer <- rep(NA, length(q))
    z <- (q - alpha)/varzeta
    locscale <- abs(sigma) < smallsigma
    possigma <- sigma > smallsigma & z > -1/sigma
    negsigma <- sigma < -smallsigma & z < -1/sigma
    answerzero <- sigma > smallsigma & z < -1/sigma
    answerone <- sigma < -smallsigma & z > -1/sigma
    the.arg <- rep(NA, length(q))
    onepsigz <- 1 + sigma[!locscale] * z[!locscale]
    positive.onepsigz <- onepsigz > 0
    logonepsigz <- rep(-Inf, length(onepsigz))
    logonepsigz[positive.onepsigz] <- logb(onepsigz[positive.onepsigz])
    the.arg[!locscale] <- logonepsigz/abs(sigma[!locscale])
    answer[answerzero] <- 0
    answer[answerone] <- 1
    answer[possigma] <- wqmf.phibf(the.arg[possigma], distribution)
    answer[negsigma] <- 1 - wqmf.phibf(the.arg[negsigma], distribution)
    answer[locscale] <- wqmf.phibf(z[locscale], distribution)
    
    return(answer)
    
  }

#' @rdname gets
#' @export

qgets <-
function (p, 
          alpha, 
          sigma, 
          varzeta, 
          distribution, 
          smallsigma = 1e-05) 
{
  
    maxlen <- max(length(p), 
                  length(alpha), 
                  length(sigma), 
                  length(varzeta))
    
    p       <- expand.vec(p, maxlen)
    alpha   <- expand.vec(alpha, maxlen)
    sigma   <- expand.vec(sigma, maxlen)
    varzeta <- expand.vec(varzeta, maxlen)
    answer <- rep(NA, length(p))
    answer[p <= 0] <- -Inf
    answer[p >= 0] <- Inf
    pgood <- p > 0 & p < 1
    locscale <- abs(sigma) <= smallsigma & pgood
    possigma <- sigma > smallsigma & pgood
    negsigma <- sigma < -smallsigma & pgood
    answer[possigma] <- (exp(abs(sigma[possigma]) * quant(p[possigma], 
                                                          distribution)) - 1)/sigma[possigma]
    answer[negsigma] <- (exp(abs(sigma[negsigma]) * quant((1 - 
                                                             p)[negsigma], distribution)) - 1)/sigma[negsigma]
    answer[locscale] <- quant(p[locscale], distribution)
    return(alpha + answer * varzeta)
  }

#' @rdname gets
#' @export

sgets <-
function (x, 
          alpha, 
          sigma, 
          varzeta, 
          distribution, 
          smallsigma = 2e-05) 
{
  
    maxlen <- max(length(x), 
                  length(alpha),
                  length(sigma),
                  length(varzeta))
    
    x <- expand.vec(x, maxlen)
    alpha <- expand.vec(alpha, maxlen)
    sigma <- expand.vec(sigma, maxlen)
    varzeta <- expand.vec(varzeta, maxlen)
    z <- rep(NA, length(x))
    answer <- rep(NA, length(x))
    locscale <- abs(sigma) < smallsigma
    z <- (x - alpha)/varzeta
    possigma <- sigma > smallsigma & z > -1/sigma
    negsigma <- sigma < -smallsigma & z < -1/sigma
    answerzero <- sigma > smallsigma & z < -1/sigma
    answerone <- sigma < -smallsigma & z > -1/sigma
    the.arg <- rep(NA, length(x))
    onepsigz <- 1 + sigma[!locscale] * z[!locscale]
    positive.onepsigz <- onepsigz > 0
    logonepsigz <- rep(-Inf, length(onepsigz))
    logonepsigz[positive.onepsigz] <- logb(onepsigz[positive.onepsigz])
    the.arg[!locscale] <- logonepsigz/abs(sigma[!locscale])
    answer[possigma] <- 1 - wqmf.phibf(the.arg[possigma], distribution)
    answer[negsigma] <- wqmf.phibf(the.arg[negsigma], distribution)
    answer[locscale] <- 1 - wqmf.phibf(z[locscale], distribution)
    answer[answerzero] <- 1
    answer[answerone] <- 0
    
    return(answer)
    
  }
