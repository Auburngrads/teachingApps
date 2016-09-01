#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

plotting_adding <- function() {

    file <- system.file("apps","plotting_adding", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
