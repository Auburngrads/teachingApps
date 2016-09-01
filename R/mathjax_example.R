#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

mathjax_example <- function() {

    file <- system.file("apps","mathjax_example", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
