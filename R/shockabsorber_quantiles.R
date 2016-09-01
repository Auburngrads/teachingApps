#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

shockabsorber_quantiles <- function() {

    file <- system.file("apps","shockabsorber_quantiles", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
