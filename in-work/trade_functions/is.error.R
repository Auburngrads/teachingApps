is.error <- function(expr) {
  
  test <- tryCatch(expr = expr, 
                   error = function(e) e)
  
  return('error'%in%class(test))
  
}