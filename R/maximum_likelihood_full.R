#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

maximum_likelihood_full <- function() {

    file <- system.file("apps","maximum_likelihood_full", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
