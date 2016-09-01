#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

survival_demo <- function() {

    file <- system.file("apps","survival_demo", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
