#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

crossing_distributions <- function() {

    file <- system.file("apps","crossing_distributions", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
