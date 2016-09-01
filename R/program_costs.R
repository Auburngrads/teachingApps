#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

program_costs <- function() {

    file <- system.file("apps","program_costs", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
