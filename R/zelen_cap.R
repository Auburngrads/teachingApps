#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

zelen_cap <- function() {

    file <- system.file("apps","zelen_cap", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
