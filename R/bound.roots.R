bound.roots <-
function (f, start.value, ...) 
{
    xfirst <- f(start.value, ...)
    if (xfirst == 0) 
        return(c(start.value - 0.1, start.value + 0.1))
    if (xfirst > 0) {
        ubound <- start.value
        repeat {
            if (start.value > 0) 
                start.value <- start.value/2
            else start.value <- start.value - 1
            xfirst <- f(start.value, ...)
            if (xfirst < 0) 
                return(c(start.value, ubound))
        }
    } else {
        lbound <- start.value
        repeat {
            if (start.value > 0) 
                start.value <- start.value * 2
            else start.value <- start.value + 1
            xfirst <- f(start.value, ...)
            if (xfirst > 0) 
                return(c(lbound, start.value))
        }
    }
}

#
#

bound.roots2 <-
  function (f, start.value, ...) 
  {
    xfirst <- f(start.value, ...)
    fderiv <- sign(f(start.value + 0.1, ...) - xfirst)
    xfirst <- xfirst * fderiv
    if (xfirst == 0)  return(c(start.value - 0.1, start.value + 0.1))
    if (xfirst > 0) {
      ubound <- start.value
      repeat {
        start.value <- start.value/2
        xfirst <- f(start.value, ...) * fderiv
        if (xfirst < 0) return(c(start.value, ubound))
      }
    } else {
      lbound <- start.value
      repeat {
        start.value <- start.value * 2
        xfirst <- f(start.value, ...) * fderiv
        if (xfirst > 0) 
          return(c(lbound, start.value))
      }
    }
  }