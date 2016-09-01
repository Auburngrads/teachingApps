#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

plotting_special <- function() {

    file <- system.file("apps","plotting_special", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
