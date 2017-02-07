#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import shinyAce
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
#'
#' @param theme code{character} A bootswatch color theme for use in code{shinythemes::shinytheme}
#' @param storyteller code{logical} Is this a storyteller app?
#' @param width code{character} Width of the printed app
#' @param height code{character} Height of the printed app
#' @param css code{character} Path to a custom css file. If code{NULL} the default css file is used 
#' @param more.opts code{list} Additional options/objects passed to the app (see Details)
#' @param ... code{list} Additional options passed to code{shiny::shinyAppDir()} 
#' 
#' @return A printed shiny app
#' @export
#'
#' @examples 
#' \dontrun{
#' appy(theme = 'spacelab', storyteller = T, pub = F)
#' }

figure1_1 <- 
function(theme = "flatly", storyteller = F, width = '100%',
         height = `if`(storyteller,'800px','600px'),
         css = NULL, more.opts = list(NA),...) {

    dir <- dirname(system.file("apps", "figure1_1", "global.R", package = "teachingApps"))
    
    teachingApps::getPackage(pkg = 'SMRD')
    
    assign.shiny.opts(opts = more.opts,
                      dir = dir,
                      theme = theme,
                      css = css,
                      story = storyteller)
    
    shiny::shinyAppDir(appDir = dir, options = list(height = height, width = width,...))

}
