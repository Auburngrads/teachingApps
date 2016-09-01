#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

distribution_sev <- function() {

    file <- system.file("apps","distribution_sev", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
