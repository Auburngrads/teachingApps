#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @export

acceptance_mtbf_mini <- function() {

    file <- system.file("apps","acceptance_mtbf_mini", "app.R", package = "teachingApps")

    shiny::runApp(file)
  
}
