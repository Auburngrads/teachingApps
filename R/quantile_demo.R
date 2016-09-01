#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

quantile_demo <- function() {

    file <- system.file("apps","quantile_demo", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
