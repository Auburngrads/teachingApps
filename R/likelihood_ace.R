#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

likelihood_ace <- function() {

    file <- system.file("apps","likelihood_ace", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
