#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

data_patterns <- function() {

    file <- system.file("apps","data_patterns", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
