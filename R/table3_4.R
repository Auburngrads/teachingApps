#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

table3_4 <- function() {

    file <- system.file("apps","table3_4", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
