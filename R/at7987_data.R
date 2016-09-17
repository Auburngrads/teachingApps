#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#'
#' @param rmd Will this app be included in an Rmarkdown document or presentation? (see details)
#'
#' @details When publishing apps using shinyapps.io or shinyServer, set \code{pub = TRUE} to prevent calls to \code{install.packages}. Calls to \code{install.packages} should not be included within an app and will result in an error.
#'
#' @export

at7987_data <- function(rmd = TRUE) {

    file <- system.file("apps", "at7987_data", "app.R", package = "teachingApps")

    teachingApps::getPackage('SMRD')

    if(rmd) { library(shiny) ; eval(parse(text = readLines(file)))
      
    } else {
      
    shiny::runApp(file)
      
    }
  
}
