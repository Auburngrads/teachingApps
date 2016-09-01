#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

figure5_6 <- function() {

    file <- system.file("apps","figure5_6", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
