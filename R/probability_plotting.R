#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

probability_plotting <- function() {

    file <- system.file("apps","probability_plotting", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
