#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import DT
#' @import data.table
#' @importFrom shiny fixedPanel uiOutput HTML htmlOutput sidebarLayout renderUI titlePanel
#' @importFrom shiny brushedPoints brushOpts br hr checkboxInput div runGadget
#' @importFrom shiny fixedPanel uiOutput HTML htmlOutput sidebarLayout tags renderUI tags
#' @importFrom shiny sidebarPanel mainPanel fluidPage navbarPage tabPanel
#' @importFrom shiny tabsetPanel withMathJax updateSelectInput updateSliderInput
#' @importFrom shiny updateNumericInput strong stopApp browserViewer shinyAppDir
#' @importFrom shiny radioButtons clickOpts runApp helpText h1 h5 h6 includeCSS
#' @importFrom shiny includeScript includeMarkdown inputPanel isolate nearPoints
#' @importFrom shiny observe observeEvent reactiveValues reactive renderText
#' @importFrom shiny runGadget dialogViewer browserViewer
#'
#' @param data A data.frame from which columns will be removed 
#' @param theme Character string naming a color theme bootswatch color theme. Must be one of the themes that can be used in \code{shinythemes::shinytheme()}
#' @param width Width of the printed app.
#' @param height Height of the printed app.
#' @param css Path to a custom css file. If \code{NULL} the default css file is used 
#' @param ... Additional options passed to \code{shiny::shinyAppDir()} 
#'  
#' @details When publishing apps using shinyapps.io or shinyServer, setting code{pub = TRUE} prevents calls to code{install.packages}. Calls to code{install.packages} should not be included within an app and will result in an error.
#' 
#' @export 
clean_columns <- 
function(data,theme = "flatly", width = '100%', 
                          css = NULL, height = '600px',...) {

do.call('library',args = list('DT'))
do.call('library',args = list('data.table'))
do.call('library',args = list('shiny'))

  `if`(is.null(css),
       css <- system.file('resources','css','teachingApps.css', package = 'teachingApps'),
       css <- css)
  
ui = fluidPage(theme = shinythemes::shinytheme(theme = theme),
               tags$head(includeCSS(css)),
               
sidebarLayout(
  sidebarPanel(width = 3,
    uiOutput("names"),
    actionButton('done',h4('Finish'), width = '100%')), 
  
    mainPanel(width = 9,
              DT::dataTableOutput("cleandata", height = "600px"))))

server = function(input, output) {

output$names <- renderUI({
  
  selectizeInput('remove', 
                 h4('Columns To Remove'),
                 choices = colnames(data),
                 selected = NULL, 
                 multiple = TRUE)
})


clean.data <- reactive({ as.data.table(data)[,as.character(input$remove):= NULL] })

  output$cleandata <- DT::renderDataTable({
    
      DT::datatable(clean.data(),
                    fillContainer = T,
                    width = '100%')
    
})
  observeEvent(input$done, { 
    
    colnums = lapply(X = input$remove,
                     FUN = function(x) { which(colnames(data)==x)})
    
    paste1 <- paste(c(unlist(colnums)), collapse = ',')
    paste2 <- parse(text = paste(c('c(',paste1,')'), collapse = ''))
    script <- paste(c('data[, -',paste2[[1]],']'), collapse = '')
    
    stopApp(list(data = as.data.frame( clean.data() ),
                 script = parse(text = script)[[1]]))
    
})
}
runGadget(app = ui,
          server = server,
          viewer = browserViewer(browser = getOption("browser")))
}
