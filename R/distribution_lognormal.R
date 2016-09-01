#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

distribution_lognormal <- function() {

    file <- system.file("apps","distribution_lognormal", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
