#' The Inverse Gaussian Distribution
#'
#' @export
#' @rdname Inverse-Gaussian

digau <-
function (x, shape, scale = 1) 
{
    return((1/(x)) * dligau(logb(x/scale), shape))
}

#'
#'

dligau <-
  function (z, shape) 
  {
    z1 <- sqrt(shape) * ((exp(z) - 1)/exp(z/2))
    return((sqrt(shape)/exp(z/2)) * dnorm(z1))
  }

#' @export
#' @rdname Inverse-Gaussian

pigau <-
  function (q, shape, scale = 1) 
  {
    tmp <- pligau(logb(q/scale), shape)
    return(tmp)
  }

#'
#'

pligau <-
  function (z, shape) 
  {
    z1 <- sqrt(shape) * ((exp(z) - 1)/exp(z/2))
    z2 <- sqrt(shape) * ((exp(z) + 1)/exp(z/2))
    return(pnorm(z1) + exp(2 * shape) * pnorm(-z2))
  }

#' @export
#' @rdname Inverse-Gaussian

qigau <-
  function (p, shape = stop("no shape arg"), scale = 1) 
  {
    max.param.len <- max(length(p), length(shape), length(scale))
    shape <- expand.vec(shape, max.param.len)
    scale <- expand.vec(scale, max.param.len)
    p <- expand.vec(p, max.param.len)
    xpigau <- function(t, shape, scale, prob) {
      return(pigau(t, shape, scale) - prob)
    }
    quant.vec <- p
    for (i in 1:length(p)) {
      fun.bounds <- bound.roots(xpigau, start.value = shape[i] * 
                                  scale[i], shape = shape[i], scale = scale[i], prob = p[i])
      cross.quant <- uniroot(xpigau, interval = fun.bounds, 
                             tol = 1e-08, shape = shape[i], scale = scale[i], 
                             prob = p[i])
      
      quant.vec[i] <- cross.quant$root
      
    }
    return(quant.vec)
  }

#'
#'

sigau <-
  function (x, shape) 
  {
    1 - pigau(x, shape)
  }

