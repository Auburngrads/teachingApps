#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

figure7_3 <- function() {

    file <- system.file("apps","figure7_3", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
