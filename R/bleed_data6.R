#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

bleed_data6 <- function() {

    file <- system.file("apps","bleed_data6", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
