#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

distribution_geng <- function() {

    file <- system.file("apps","distribution_geng", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
