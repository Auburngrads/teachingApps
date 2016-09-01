#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

central_limit <- function() {

    file <- system.file("apps","central_limit", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
