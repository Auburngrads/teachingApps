#' Add a bootswatch color theme to an app 
#'
#' @param theme \code{character} A bootstrap theme provided by shinythemes::shinytheme
#' 
#' @importFrom shinythemes shinytheme
#' @importFrom shiny getShinyOption
#' 
#' @export
add_theme <- function(theme = NULL)
{
    if(is.null(theme) && is.null(getShinyOption("theme"))) {
      
      return(shinythemes::shinytheme(theme = 'flatly'))
      
    } else {
      
      return(shinythemes::shinytheme(theme = theme))
      
    }
}
