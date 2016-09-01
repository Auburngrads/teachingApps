#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

diagram_nonrepairable <- function() {

    file <- system.file("apps","diagram_nonrepairable", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
