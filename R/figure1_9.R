#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

figure1_9 <- function() {

    file <- system.file("apps","figure1_9", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
