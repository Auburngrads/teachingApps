#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

offbase_libraries <- function() {

    file <- system.file("apps","offbase_libraries", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
