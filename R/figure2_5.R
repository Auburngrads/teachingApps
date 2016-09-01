#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

figure2_5 <- function() {

    file <- system.file("apps","figure2_5", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
