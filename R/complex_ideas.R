#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

complex_ideas <- function() {

    file <- system.file("apps","complex_ideas", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
