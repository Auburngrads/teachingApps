#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

figure10_4 <- function() {

    file <- system.file("apps","figure10_4", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
