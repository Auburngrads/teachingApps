#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

ace_very_normal <- function() {

    file <- system.file("apps","ace_very_normal", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
