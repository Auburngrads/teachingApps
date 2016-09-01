#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

stress_strength <- function() {

    file <- system.file("apps","stress_strength", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
