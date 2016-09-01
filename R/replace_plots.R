#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

replace_plots <- function() {

    file <- system.file("apps","replace_plots", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
