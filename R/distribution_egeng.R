#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

distribution_egeng <- function() {

    file <- system.file("apps","distribution_egeng", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
