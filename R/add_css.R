#' Dynamically add css style rules to an app 
#'
#' @importFrom shiny includeCSS getShinyOption insertUI tags
#' 
#' @export
add_style <- function()
{

  main <- tags$head(tags$link(rel = 'stylesheet', 
                              type = 'text/css',
                              href = 'teachingApps/css/teachingApps.css'))
                   
  return(main)
}


#' Dynamically add a theme to an app 
#'
#' @param theme \code{character} A bootstrap theme provided by shinythemes::shinytheme
#' 
#' @importFrom shinythemes shinytheme
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

#' Dynamically add a branding to a navbarPage app 
#'
#' @importFrom shiny includeCSS getShinyOption insertUI tags
#' 
#' @export
add_brand <- function() 
{
   tags$footer(getShinyOption("sign"))
}

