#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

htmlwidgets_shiny <- function() {

    file <- system.file("apps","htmlwidgets_shiny", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
