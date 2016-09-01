#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

figure6_2 <- function() {

    file <- system.file("apps","figure6_2", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
