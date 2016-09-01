#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

simultaneous_skills <- function() {

    file <- system.file("apps","simultaneous_skills", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
