#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

lfp1370_data <- function() {

    file <- system.file("apps","lfp1370_data", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
