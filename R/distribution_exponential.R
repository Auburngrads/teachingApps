#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

distribution_exponential <- function() {

    file <- system.file("apps","distribution_exponential", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
