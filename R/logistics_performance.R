#' International Logistics Performance Index App
#'
#' @description Description
#'
#' @importFrom shinythemes shinytheme
#' @importFrom shinyAce aceEditor
#' @importFrom shiny fixedPanel uiOutput HTML htmlOutput sidebarLayout renderUI titlePanel
#' @importFrom shiny brushedPoints brushOpts br hr checkboxInput div
#' @importFrom shiny fixedPanel uiOutput HTML htmlOutput sidebarLayout tags renderUI 
#' @importFrom shiny sidebarPanel mainPanel fluidPage navbarPage tabPanel h2 h4
#' @importFrom shiny tabsetPanel withMathJax updateSelectInput updateSliderInput
#' @importFrom shiny updateNumericInput strong stopApp shinyAppDir
#' @importFrom shiny radioButtons clickOpts runApp helpText h1 h5 h6 includeCSS
#' @importFrom shiny includeScript includeMarkdown inputPanel isolate nearPoints
#' @importFrom shiny observe observeEvent reactiveValues reactive renderText selectInput
#' @importFrom shiny actionButton selectizeInput plotOutput renderPlot fillRow fillCol
#'
#' @param theme code{character} A bootswatch color theme for use in code{shinythemes::shinytheme}
#' @param width code{character} Width of the printed app
#' @param height code{character} Height of the printed app
#' @param icon fontAwesome icon placed at the bottom of navbarPage apps
#' @param more.opts code{list} Additional options/objects passed to the app (see Details)
#' @param ... code{list} Additional options passed to code{shiny::shinyAppDir()} 
#' 
#' @family plotly apps
#' 
#' @return A printed shiny app
#' @export
#'
#' @examples 
#' dontrun{
#' appy(theme = 'spacelab', height = '600px')
#' }
logistics_performance <- 
function(theme = "flatly", storyteller = T, width = '100%',
         height = `if`(storyteller,'800px','600px'),
         more.opts = list(NA),...) {
    dir <- dirname(system.file("apps", "logistics_performance", "global.R", package = "teachingApps"))
    
    teachingApps::getPackage('plotly') 
    teachingApps::getPackage('readr')
    teachingApps::getPackage('dplyr')
    teachingApps::getPackage('tidyr')
    teachingApps::getPackage('DT')
    teachingApps::getPackage('radarchart')
    teachingApps::getPackage('magrittr')
    
    teachingApps::assign.shiny.opts(opts = more.opts,
                                    dir = dir,
                                    theme = theme,
                                    icon = icon)
    
    shiny::shinyAppDir(appDir = dir, 
                       options = list(height = height, width = width,...))
}
