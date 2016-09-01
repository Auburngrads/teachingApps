#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

exp_numerical <- function() {

    file <- system.file("apps","exp_numerical", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
