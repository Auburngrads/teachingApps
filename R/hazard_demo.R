#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

hazard_demo <- function() {

    file <- system.file("apps","hazard_demo", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
