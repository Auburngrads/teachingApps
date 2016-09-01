#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

distribution_geometric <- function() {

    file <- system.file("apps","distribution_geometric", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
