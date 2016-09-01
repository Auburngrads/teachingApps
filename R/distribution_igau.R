#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

distribution_igau <- function() {

    file <- system.file("apps","distribution_igau", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
