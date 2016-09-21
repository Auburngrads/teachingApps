#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#'
#' @param rmd Will this app be included in an Rmarkdown document or presentation? (see details)
#'
#' @details When publishing apps using shinyapps.io or shinyServer, set \code{pub = TRUE} to prevent calls to \code{install.packages}. Calls to \code{install.packages} should not be included within an app and will result in an error.
#'
#' @export

htmlwidgets_shiny <- function(rmd = TRUE, pub = FALSE) {

    file <- system.file("apps", "htmlwidgets_shiny", "app.R", package = "teachingApps")

 teachingApps::getPackage(pub = pub, pkg  = 'metricsgraphics')
 teachingApps::getPackage(pub = pub, pkg  = 'dygraphs')
 teachingApps::getPackage(pub = pub, pkg  = 'leaflet')
 teachingApps::getPackage(pub = pub, pkg  = 'threejs')
 teachingApps::getPackage(pub = pub, pkg  = 'd3heatmap')
 teachingApps::getPackage(pub = pub, pkg  = 'parcoords', repo = 'timelyportfolio')
 teachingApps::getPackage(pub = pub, pkg  = 'taucharts', repo = 'hrbrmstr')
 teachingApps::getPackage(pub = pub, pkg  = 'htmlwidgets')
 teachingApps::getPackage(pub = pub, pkg  = 'plotly')

    if(rmd) { 
      
      do.call(library, list(package = 'shiny', character.only = T))
      
      evaluate::evaluate(file(file))
      
    } else {
      
    shiny::runApp(file)
      
    }
  
}
