#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

maximum_likelihood <- function() {

    file <- system.file("apps","maximum_likelihood", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
