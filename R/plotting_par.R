#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

plotting_par <- function() {

    file <- system.file("apps","plotting_par", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
