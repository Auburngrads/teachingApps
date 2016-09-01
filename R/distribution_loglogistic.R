#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

distribution_loglogistic <- function() {

    file <- system.file("apps","distribution_loglogistic", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
