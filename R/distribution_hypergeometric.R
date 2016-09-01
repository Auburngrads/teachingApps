#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

distribution_hypergeometric <- function() {

    file <- system.file("apps","distribution_hypergeometric", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
