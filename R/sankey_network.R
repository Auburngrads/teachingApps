#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

sankey_network <- function() {

    file <- system.file("apps","sankey_network", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
