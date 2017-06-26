#' Dynamically add css rules to an app 
#'
#' @param main.css The main CSS file
#' @param user.css A user specified CSS file 
#' @param name The name of the app
#' 
#' @importFrom shiny includeCSS getShinyOption insertUI tags
#' 
#' @export
add_styles <- 
  function(main.css = getShinyOption("CSS"),
           user.css = getShinyOption("css"),
           name = getShinyOption("appName"))
{

  # zout <- list()
  # zout$insert <- insertUI('head', 'afterBegin',
  #                         ui = list(tags$head(includeCSS(main.css)),
  #                                   tags$head(includeCSS(user.css))))
                          #tags$footer(HTML(teachingApps::signature(name)))
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
add_themes <- 
  function(theme = NULL)
{
    if(is.null(theme) && is.null(getShinyOption("theme"))) {
      
      return(shinythemes::shinytheme(theme = 'flatly'))
      
    } else {
      
      return(shinythemes::shinytheme(theme = theme))
      
    }
}

#' Dynamically add css rules to an app 
#'
#' @param main.css The main CSS file
#' @param user.css A user specified CSS file 
#' @param name The name of the app
#' 
#' @importFrom shiny includeCSS getShinyOption insertUI tags
#' 
#' @export
add_footer <- 
 function() {
   
   tags$footer(getShinyOption("sign"))
 }

