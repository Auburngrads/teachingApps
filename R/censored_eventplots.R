#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

censored_eventplots <- function() {

    file <- system.file("apps","censored_eventplots", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
