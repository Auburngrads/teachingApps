#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

shockabsorber_probabilities <- function() {

    file <- system.file("apps","shockabsorber_probabilities", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
