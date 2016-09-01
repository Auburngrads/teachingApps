#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

censoring_types <- function() {

    file <- system.file("apps","censoring_types", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
