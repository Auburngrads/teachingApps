#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

acceptance_proportion <- function() {

    file <- system.file("apps","acceptance_proportion", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
