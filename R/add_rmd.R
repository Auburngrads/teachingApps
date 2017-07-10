#' Add an rmarkdown file to an app
#' 
#' @description Run inline and stand-alone code chunks and include results
#' as part of a shiny app. Include \code{LaTeX}-typeset equations with MathJax
#' 
#' @importFrom shiny getShinyOption withMathJax HTML addResourcePath
#' @importFrom knitr knit
#' @importFrom markdown markdownToHTML 
#' 
#' @param rmd \code{character} Name of an rmarkdown file saved in the app directory
#' @param path Path to a file outside of the app directory
#' @seealso \code{\link{add_server} \link{add_ui}}
#' 
#' @examples 
#' \dontrun{
#' # see examples in add_server and add_ui documentation
#' }
#' @export
add_rmd <- function(rmd, path) {
  
  no_rmd  <- missing(rmd)  || is.null(rmd)  || is.na(rmd)
  no_path <- missing(path) || is.null(path) || is.na(path)
  
  if( no_rmd &&  no_path) stop('Either rmd or path must be specified')
  if(!no_rmd && !no_path) stop('Only one of app or path should be specified')
   
  if(no_path) {
    
     file <- file.path(getShinyOption('appDir'), rmd)
  
     } else {
         
     Path <- shiny::addResourcePath(basename(dirname(path)), dirname(path))
     file <- file.path(path)
    
     }
  
   withMathJax(HTML(markdown::markdownToHTML(knitr::knit(file))))
  
}
