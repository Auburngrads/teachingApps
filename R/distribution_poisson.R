#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

distribution_poisson <- function() {

    file <- system.file("apps","distribution_poisson", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
