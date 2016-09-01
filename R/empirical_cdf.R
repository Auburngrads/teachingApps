#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

empirical_cdf <- function() {

    file <- system.file("apps","empirical_cdf", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
