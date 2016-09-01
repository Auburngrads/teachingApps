#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

cdf_demo <- function() {

    file <- system.file("apps","cdf_demo", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
