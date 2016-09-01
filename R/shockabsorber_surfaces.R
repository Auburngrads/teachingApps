#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

shockabsorber_surfaces <- function() {

    file <- system.file("apps","shockabsorber_surfaces", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
