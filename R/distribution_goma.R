#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

distribution_goma <- function() {

    file <- system.file("apps","distribution_goma", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
