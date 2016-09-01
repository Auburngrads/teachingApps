#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

plotting_positions <- function() {

    file <- system.file("apps","plotting_positions", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
