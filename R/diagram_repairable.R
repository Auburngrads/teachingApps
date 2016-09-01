#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

diagram_repairable <- function() {

    file <- system.file("apps","diagram_repairable", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
