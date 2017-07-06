#' Add a bootswatch color theme to an app 
#'
#' @param theme \code{character} A bootswatch theme name (see details)
#' @details This function should not be called directly but is invoked when an 
#'          app is rendered.
#'          
#'          Themes are provided by calling \code{shinythemes::shinytheme}, 
#'          therefore available theme names are those provided by the 
#'          \code{shinythemes} package.  By default, \code{theme = 'flatly'}
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
