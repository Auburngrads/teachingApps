#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

crossing_distributions2 <- function() {

    file <- system.file("apps","crossing_distributions2", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
