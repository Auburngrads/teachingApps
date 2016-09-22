#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#'
#' @param rmd Will this app be included in an Rmarkdown document or presentation? (see details)
#' @param pub Will this app be published? (see details)
#' @param theme Character string naming a color theme bootswatch color theme. Must be one of the themes that can be used in code{shinythemes::shinytheme()}
#'  
#' @details When publishing apps using shinyapps.io or shinyServer, set code{pub = TRUE} to prevent calls to code{install.packages}. Calls to code{install.packages} should not be included within an app and will result in an error.
#'
#' @export

distribution_igau <- function(rmd = TRUE, pub = FALSE, theme = 'flatly') {

    file <- system.file("apps", "distribution_igau", "app.R", package = "teachingApps")

    teachingApps::getPackage(pub = pub, pkg  = 'SMRD')
teachingApps::getPackage(pub = pub, pkg  = 'metricsgraphics')

    assign('theme', theme, envir = .jkf.apps)
    
    if(rmd) { 
      
      do.call(library, list(package = 'shiny', character.only = T))
      
      eval(parse(file = file))
      
    } else {
      
    shiny::runApp(file)
      
    }
  
}
