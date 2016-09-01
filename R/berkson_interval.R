#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

berkson_interval <- function() {

    file <- system.file("apps","berkson_interval", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
