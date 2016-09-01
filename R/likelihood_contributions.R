#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

likelihood_contributions <- function() {

    file <- system.file("apps","likelihood_contributions", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
