#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

turbine_data6 <- function() {

    file <- system.file("apps","turbine_data6", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
