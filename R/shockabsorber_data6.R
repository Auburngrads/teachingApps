#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

shockabsorber_data6 <- function() {

    file <- system.file("apps","shockabsorber_data6", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
