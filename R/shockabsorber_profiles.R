#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

shockabsorber_profiles <- function() {

    file <- system.file("apps","shockabsorber_profiles", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
