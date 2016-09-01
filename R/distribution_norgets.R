#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

distribution_norgets <- function() {

    file <- system.file("apps","distribution_norgets", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
