#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

figure7_1 <- function() {

    file <- system.file("apps","figure7_1", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
