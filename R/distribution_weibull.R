#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

distribution_weibull <- function() {

    file <- system.file("apps","distribution_weibull", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
