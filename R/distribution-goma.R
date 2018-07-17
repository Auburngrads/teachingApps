#' The Gompertz Makeham Distribution
#'
#' @export
#' @rdname Gomphertz-Makeham


dgoma <-
function (x, shape, shape2, scale = 1) 
{
    return((1/(x)) * dlgoma(logb(x/scale), shape, shape2))
}

#'
#'

dlgoma <-
  function (z, shape, shape2) 
  {
    return(exp(z) * (shape2 + exp(exp(z) - shape)) * slgoma(z, shape, shape2))
  }

#' @export
#' @rdname Gomphertz-Makeham

pgoma <-
  function (q, shape, shape2, scale = 1) 
  {
    return(plgoma(logb(q/scale), shape, shape2))
  }

#'
#'

plgoma <-
  function (z, shape, shape2) 
  {
    return(1 - slgoma(z, shape, shape2))
  }

#' @export
#' @rdname Gomphertz-Makeham

qgoma <-
  function (p, shape = stop("no shape arg"), shape2 = stop("no shape2 arg"), 
            scale = 1) 
  {
    max.param.len <- max(length(p), length(shape), length(shape2), 
                         length(scale))
    shape <- expand.vec(shape, max.param.len)
    shape2 <- expand.vec(shape2, max.param.len)
    scale <- expand.vec(scale, max.param.len)
    p <- expand.vec(p, max.param.len)
    xpgoma <- function(t, shape, shape2, scale, prob) {
      return(pgoma(t, shape, shape2, scale) - prob)
    }
    quant.vec <- p
    for (i in 1:length(p)) {
      fun.bounds <- bound.roots(xpgoma, start.value = shape[i] * 
                                  scale[i], shape = shape[i], shape2 = shape2[i], scale = scale[i], 
                                prob = p[i])
      cross.quant <- uniroot(xpgoma, interval = fun.bounds, 
                             tol = 1e-08, shape = shape[i], shape2 = shape2[i], 
                             scale = scale[i], prob = p[i])
      
      quant.vec[i] <- cross.quant$root
      
    }
    return(quant.vec)
  }

#'
#'

sgoma <-
  function (x, shape, shape2) 
  {
    1 - pgoma(x, shape, shape2)
  }

#'
#'

slgoma <-
  function (z, shape, shape2) 
  {
    return((ssev(exp(z) - shape)/ssev(-shape)) * exp(-shape2 * exp(z)))
  }
