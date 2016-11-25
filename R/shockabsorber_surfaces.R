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
#' @importFrom shiny updateNumericInput strong stopApp browserViewer shinyAppDir
#' @importFrom shiny radioButtons clickOpts runApp helpText h1 h5 h6 includeCSS
#' @importFrom shiny includeScript includeMarkdown inputPanel isolate nearPoints
#' @importFrom shiny observe observeEvent reactiveValues reactive renderText
#'
#'
#' @param pub Will the app be published (deployed)? (see details)
#' @param theme Character string naming a color theme bootswatch color theme. Must be one of the themes that can be used in code{shinythemes::shinytheme()}
#' @param rmd Will the app code be included in an interactive Rmarkdown document or presentation with code{runtime: shiny}? (see details)
#' @param width Width of the printed app. Used for code{rmd = TRUE}, otherwise ignored
#' @param height Height of the printed app. Used for code{rmd = TRUE}, otherwise ignored
#' @param ... Additional arguments passed to code{shiny::runApp()} 
#'  
#' @details When publishing apps using shinyapps.io or shinyServer, setting code{pub = TRUE} prevents calls to code{install.packages}. Calls to code{install.packages} should not be included within an app and will result in an error.
#' 
#' When code{rmd = FALSE} the app is run using code{shiny::runApp}, addition arguments can be passed via the code{...} argument.  When code{rmd = TRUE}, code{shiny::shinyAppDir} is used the code{width} and code{height} arguments must be specified.
#'
#' @export

shockabsorber_surfaces <- function(pub = FALSE, theme = "flatly", rmd = FALSE, width = '100%', height = '800px',...) {

    dir <- dirname(system.file("apps", "shockabsorber_surfaces", "args.R", package = "teachingApps"))

    teachingApps::getPackage(pub = pub, pkg  = 'SMRD')
arg2 <- data.frame(theme  = theme,
                       appDir = dir,
                      appName = basename(dir),
                      stringsAsFactors = F)
    
        file.create(paste(c(dir,'args.R'), collapse = '/'))
    
    dump('arg2', file = paste(c(dir,'args.R'), collapse = '/'))
    
    if(rmd) {

    shiny::shinyAppDir(appDir = dir, options = list(height = height, width = width))

    } else {
      
    shiny::runApp(dir,...)
      
    }
  
}
