#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

distribution_levgets <- function() {

    file <- system.file("apps","distribution_levgets", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
