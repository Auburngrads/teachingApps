#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

rstudio_toolchain <- function() {

    file <- system.file("apps","rstudio_toolchain", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
