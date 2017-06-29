#' Nests an rmarkdown file within an app
#' 
#' @description Run inline and stand-alone code chunks and include results
#' as part of a shiny app. Include \code{LaTeX}-typeset equations with MathJax
#' 
#' @importFrom shiny getShinyOption withMathJax HTML
#' @importFrom knitr knit
#' @importFrom markdown markdownToHTML 
#' 
#' @param rmd An rmarkdown file saved in the app directory
#' 
#' @seealso \code{\link{add_server} \link{add_ui}}
#' 
#' @examples \dontrun{# see examples in add_server and add_ui documentation}
#' @export
add_rmd <- function(rmd) {
  
  rmd <- paste(c(getShinyOption('appDir'),rmd), collapse = '/')
   withMathJax(HTML(markdown::markdownToHTML(knitr::knit(rmd))))
  
}
