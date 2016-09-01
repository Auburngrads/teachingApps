#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

data_science <- function() {

    file <- system.file("apps","data_science", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
