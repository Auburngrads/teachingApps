#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

confidence_intervals <- function() {

    file <- system.file("apps","confidence_intervals", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
