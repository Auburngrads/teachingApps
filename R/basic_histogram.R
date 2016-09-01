#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

basic_histogram <- function() {

    file <- system.file("apps","basic_histogram", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
