#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

distribution_logistic <- function() {

    file <- system.file("apps","distribution_logistic", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
