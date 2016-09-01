#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

bent_probplot <- function() {

    file <- system.file("apps","bent_probplot", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
