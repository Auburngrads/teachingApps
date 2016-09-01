#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

at7987_data <- function() {

    file <- system.file("apps","at7987_data", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
