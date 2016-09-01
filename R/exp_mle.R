#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

exp_mle <- function() {

    file <- system.file("apps","exp_mle", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
