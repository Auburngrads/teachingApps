#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

diagram_both <- function() {

    file <- system.file("apps","diagram_both", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
