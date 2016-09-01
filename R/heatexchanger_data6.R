#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

heatexchanger_data6 <- function() {

    file <- system.file("apps","heatexchanger_data6", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
