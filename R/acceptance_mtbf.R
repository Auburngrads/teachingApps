#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

acceptance_mtbf <- function() {

    file <- system.file("apps","acceptance_mtbf", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
