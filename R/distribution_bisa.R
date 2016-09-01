#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

distribution_bisa <- function() {

    file <- system.file("apps","distribution_bisa", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
