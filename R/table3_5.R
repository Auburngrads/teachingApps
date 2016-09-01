#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

table3_5 <- function() {

    file <- system.file("apps","table3_5", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
