#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

reliability_environment <- function() {

    file <- system.file("apps","reliability_environment", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
