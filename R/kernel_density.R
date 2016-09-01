#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

kernel_density <- function() {

    file <- system.file("apps","kernel_density", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
