#' Dynamically set the height of an app 
#'
#' @param height \code{character} Default height of an app (in px)
#' @param dir \code{character} App directory path    
#'
set_height <- function(height = NULL, dir = NULL) {
  
  if (is.null(height)) {
    
    container <- source(file.path(dir,'ui.R'), print.eval = F)$value
         type <- eval(parse(text = container))[1][[1]]$name
    
    if (is.null(type)) type <- eval(parse(text = container))[1][[1]][[1]]$name
    
    switch(type, 
           'div'  = return('600px'),
           'nav'  = return('800px'),
           'head' = return('800px'))
  } else {
    
    return(height)
    
  }
  
}
