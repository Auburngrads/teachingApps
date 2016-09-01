#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

shock_absorber8 <- function() {

    file <- system.file("apps","shock_absorber8", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
