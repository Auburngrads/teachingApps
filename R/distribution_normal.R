#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

distribution_normal <- function() {

    file <- system.file("apps","distribution_normal", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
