#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

figure3_2 <- function() {

    file <- system.file("apps","figure3_2", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
