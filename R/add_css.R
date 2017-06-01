#' Dynamically add css rules to an app 
#'
#' @param main.css The main CSS file
#' @param user.css A user specified CSS file 
#' @param name The name of the app
#' 
#' @importFrom shiny includeCSS getShinyOption insertUI tags
#' 
#' @export
add_css <- 
  function(main.css = getShinyOption("CSS"),
           user.css = getShinyOption("css"),
           name = getShinyOption("appName"))
{

  return(insertUI('head', 'afterBegin',
         ui = list(tags$head(includeCSS(main.css)),
                   tags$head(includeCSS(user.css))
                   #tags$footer(HTML(teachingApps::signature(name)))
                   )))
}