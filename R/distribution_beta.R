#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

distribution_beta <- function() {

    file <- system.file("apps","distribution_beta", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
