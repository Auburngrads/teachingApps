#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

random_generator <- function() {

    file <- system.file("apps","random_generator", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
