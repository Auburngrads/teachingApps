#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

basic_dashboard <- function() {

    file <- system.file("apps","basic_dashboard", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
