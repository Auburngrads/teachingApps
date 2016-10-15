#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @importFrom shiny shinyApp renderPrint renderPlot actionButton h2 h3 h4
#' @importFrom shiny brushedPoints brushOpts br hr checkboxInput div runGadget
#' @importFrom shiny fixedPanel uiOutput HTML htmlOutput sidebarLayout 
#' @importFrom shiny sidebarPanel mainPanel fluidPage navbarPage tabPanel
#' @importFrom shiny tabsetPanel withMathJax updateSelectInput updateSliderInput
#' @importFrom shiny updateNumericInput strong stopApp browserViewer
#' @importFrom shiny radioButtons clickOpts runApp helpText h1 h5 h6 includeCSS
#' @importFrom shiny includeScript includeMarkdown inputPanel isolate nearPoints
#' @importFrom shiny observe observeEvent reactiveValues reactive renderText
#'
#'
#' @param pub Will this app be published? (see details)
#' @param theme Character string naming a color theme bootswatch color theme. Must be one of the themes that can be used in code{shinythemes::shinytheme()}
#' @param rmd Will this be included in a Rmarkdown document or presentation?
#' @param ... Additional arguments for code{shiny::runApp()} 
#'  
#' @details When publishing apps using shinyapps.io or shinyServer, set code{pub = TRUE} to prevent calls to code{install.packages}. Calls to code{install.packages} should not be included within an app and will result in an error.
#'
#' @export

distribution_geometric <- function(pub = FALSE, theme = 'flatly', rmd = FALSE,...) {

    file <- system.file("apps", "distribution_geometric", "app.R", package = "teachingApps")

    teachingApps::getPackage(pub = pub, pkg  = "metricsgraphics")
arg2 <- list(theme  = as.character(theme),
                 appDir = as.character(dirname(file)),
                 appName = as.character(basename(dirname(file))))
    
    taEnv <- new.env(parent = emptyenv())
    
    assign('arg2', value = arg2, envir = taEnv, inherits = T)
    
    if(rmd) {

      do.call(library, list(package = 'shiny', character.only = T))

      eval(parse(file = file))

    } else {
      
    shiny::runApp(file,...)
      
    }
  
}
