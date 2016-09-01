#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

berkson200_profile <- function() {

    file <- system.file("apps","berkson200_profile", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
