#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

diagrammer_network <- function() {

    file <- system.file("apps","diagrammer_network", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
