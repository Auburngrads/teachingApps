#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

distribution_binomial <- function() {

    file <- system.file("apps","distribution_binomial", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
