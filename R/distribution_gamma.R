#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

distribution_gamma <- function() {

    file <- system.file("apps","distribution_gamma", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
