#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#'
#' @param pub Will this app be published? (see details)
#'
#' @details When publishing apps using shinyapps.io or shinyServer, set \code{pub = TRUE} to prevent calls to \code{install.packages}. Calls to \code{install.packages} should not be included within an app and will result in an error.
#'
#' @export

distribution_geometric <- function(pub = FALSE) {

    file <- system.file("apps", "distribution_geometric", "app.R", package = "teachingApps")

    teachingApps::getPackage("metricsgraphics")
  
shinyApp(options = list(height = "700px"), 
         
ui = fluidPage(theme = shinythemes::shinytheme("flatly"), 
               try(includeCSS(system.file("css", 
                                          "my-shiny.css", 
                                          package = "teachingApps")), silent = TRUE), 
sidebarLayout(
  sidebarPanel(width = 3, 

    shiny::runApp(file)
  
}
