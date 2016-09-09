#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#'
#' @param pub Will this app be published? (see details)
#'
#' @details When publishing apps using shinyapps.io or shinyServer, set \code{pub = TRUE} to prevent calls to \code{install.packages}. Calls to \code{install.packages} should not be included within an app and will result in an error.
#'
#' @export

stress_strength <- function(pub = FALSE) {

    file <- system.file("apps", "stress_strength", "app.R", package = "teachingApps")

    

    shiny::runApp(file)
  
}
