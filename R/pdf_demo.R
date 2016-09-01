#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

pdf_demo <- function() {

    file <- system.file("apps","pdf_demo", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
