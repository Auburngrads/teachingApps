#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

plotting_basic <- function() {

    file <- system.file("apps","plotting_basic", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
