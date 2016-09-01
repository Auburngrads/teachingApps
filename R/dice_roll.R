#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

dice_roll <- function() {

    file <- system.file("apps","dice_roll", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
