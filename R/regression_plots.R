#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

regression_plots <- function() {

    file <- system.file("apps","regression_plots", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
