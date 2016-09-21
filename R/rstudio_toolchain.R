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
#' 
#' @details When publishing apps using shinyapps.io or shinyServer, set \code{pub = TRUE} to prevent calls to \code{install.packages}. Calls to \code{install.packages} should not be included within an app and will result in an error.
#'
#' @export

rstudio_toolchain <- function(rmd = TRUE, pub = FALSE) {

    file <- system.file("apps", "rstudio_toolchain", "app.R", package = "teachingApps")

    teachingApps::getPackage(pub = pub, pkg  = 'codemirrorR', repo = 'timelyportfolio')

    if(rmd) { 
      
      do.call(library, list(package = 'shiny', character.only = T))
      
      eval(parse(file = file))
      
    } else {
      
    shiny::runApp(file)
      
    }
  
}
