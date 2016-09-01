#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

superalloy_data17 <- function() {

    file <- system.file("apps","superalloy_data17", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
