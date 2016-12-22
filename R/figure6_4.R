#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
#' @importFrom shiny fixedPanel uiOutput HTML htmlOutput sidebarLayout renderUI titlePanel
#' @importFrom shiny brushedPoints brushOpts br hr checkboxInput div runGadget
#' @importFrom shiny fixedPanel uiOutput HTML htmlOutput sidebarLayout tags renderUI 
#' @importFrom shiny sidebarPanel mainPanel fluidPage navbarPage tabPanel h2 h4
#' @importFrom shiny tabsetPanel withMathJax updateSelectInput updateSliderInput
#' @importFrom shiny updateNumericInput strong stopApp browserViewer shinyAppDir
#' @importFrom shiny radioButtons clickOpts runApp helpText h1 h5 h6 includeCSS
#' @importFrom shiny includeScript includeMarkdown inputPanel isolate nearPoints
#' @importFrom shiny observe observeEvent reactiveValues reactive renderText selectInput
#' @importFrom shiny actionButton selectizeInput plotOutput renderPlot fillRow fillCol


#'
#'
#' @param theme Character string naming a color theme bootswatch color theme. Must be one of the themes that can be used in code{shinythemes::shinytheme()}
#' @param width Width of the printed app. Used for code{rmd = TRUE}, otherwise ignored
#' @param height Height of the printed app. Used for code{rmd = TRUE}, otherwise ignored
#' @param storyteller Is this a storyteller app?
#' @param css Path to a custom css file. If code{NULL} the default css file is used 
#' @param more.opts Additional options to be passed to the app (see Details)
#' @param ... Additional arguments passed to code{shiny::runApp()} 


#'  
#' @details When publishing apps using shinyapps.io or shinyServer, setting code{pub = TRUE} prevents calls to code{install.packages}. Calls to code{install.packages} should not be included within an app and will result in an error.
#' 
#' When code{rmd = FALSE} the app is run using code{shiny::runApp}, addition arguments can be passed via the code{...} argument.  When code{rmd = TRUE}, code{shiny::shinyAppDir} is used the code{width} and code{height} arguments must be specified.
#'
#' @export

figure6_4 <- function(theme = "flatly",  width = '100%', storyteller = F, css = NULL,
                            height = `if`(storyteller,'800px','600px'),
                            more.opts = list(NA),...) {

    dir <- dirname(system.file("apps", "figure6_4", "global.R", package = "teachingApps"))
    

    teachingApps::getPackage(pkg = 'SMRD')
assign.shiny.opts(opts = more.opts,
                      dir = dir,
                      theme = theme,
                      css = css,
                      story = storyteller)
    
    shiny::shinyAppDir(appDir = dir, options = list(height = height, width = width))

}

