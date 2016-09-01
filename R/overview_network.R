#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

overview_network <- function() {

    file <- system.file("apps","overview_network", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
