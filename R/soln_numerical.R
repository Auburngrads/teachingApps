#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

soln_numerical <- function() {

    file <- system.file("apps","soln_numerical", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
