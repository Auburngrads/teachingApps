#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

cumhaz_demo <- function() {

    file <- system.file("apps","cumhaz_demo", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
