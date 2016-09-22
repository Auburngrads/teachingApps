#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @import shiny
#' @import metricsgraphics
#' @import plotly
#' @import dygraphs
#' @import htmlwidgets
#' @import leaflet
#' @import d3heatmap
#' @import threejs
#'
#' @param rmd Will this app be included in an Rmarkdown document or presentation? (see details)
#' @param pub Will this app be published? (see details)
#' @param theme Character string naming a color theme bootswatch color theme. Must be one of the themes that can be used in code{shinythemes::shinytheme()}
#'  
#' @details When publishing apps using shinyapps.io or shinyServer, set code{pub = TRUE} to prevent calls to code{install.packages}. Calls to code{install.packages} should not be included within an app and will result in an error.
#'
#' @export

htmlwidgets_shiny <- function(rmd = TRUE, pub = FALSE, theme = 'flatly') {

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

    assign('theme', theme, envir = .jkf.apps)
    
    if(rmd) { 
      
      do.call(library, list(package = 'shiny', character.only = T))
      
      eval(parse(file = file))
      
    } else {
      
    shiny::runApp(file)
      
    }
  
}
