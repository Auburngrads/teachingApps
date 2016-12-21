#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import DT
#' @import data.table
#' @importFrom shiny shinyApp renderPrint renderPlot actionButton h2 h3 h4
#' @importFrom shiny brushedPoints brushOpts br hr checkboxInput div runGadget
#' @importFrom shiny fixedPanel uiOutput HTML htmlOutput sidebarLayout tags
#' @importFrom shiny sidebarPanel mainPanel fluidPage navbarPage tabPanel
#' @importFrom shiny tabsetPanel withMathJax updateSelectInput updateSliderInput
#' @importFrom shiny updateNumericInput strong stopApp browserViewer shinyAppDir
#' @importFrom shiny radioButtons clickOpts runApp helpText h1 h5 h6 includeCSS
#' @importFrom shiny includeScript includeMarkdown inputPanel isolate nearPoints
#' @importFrom shiny observe observeEvent reactiveValues reactive renderText
#'
#'
#' @param theme Character string naming a color theme bootswatch color theme. Must be one of the themes that can be used in code{shinythemes::shinytheme()}
#' @param height Height of the printed app. Used for code{rmd = TRUE}, otherwise ignored
#' @param css Path to a custom css file. If code{NULL} the default css file is used 
#' @param ... Additional arguments passed to code{shiny::runApp()} 
#'  
#' @details When publishing apps using shinyapps.io or shinyServer, setting code{pub = TRUE} prevents calls to code{install.packages}. Calls to code{install.packages} should not be included within an app and will result in an error.
#' 
#' @export 

clean_columns <- function(data,theme = "flatly", width = '100%', 
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


#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import miniUI
#' @importFrom shiny shinyApp renderPrint renderPlot actionButton h2 h3 h4
#' @importFrom shiny brushedPoints brushOpts br hr checkboxInput div runGadget
#' @importFrom shiny fixedPanel uiOutput HTML htmlOutput sidebarLayout tags
#' @importFrom shiny sidebarPanel mainPanel fluidPage navbarPage tabPanel
#' @importFrom shiny tabsetPanel withMathJax updateSelectInput updateSliderInput
#' @importFrom shiny updateNumericInput strong stopApp browserViewer shinyAppDir
#' @importFrom shiny radioButtons clickOpts runApp helpText h1 h5 h6 includeCSS
#' @importFrom shiny includeScript includeMarkdown inputPanel isolate nearPoints
#' @importFrom shiny observe observeEvent reactiveValues reactive renderText
#'
#'
#' @param theme Character string naming a color theme bootswatch color theme. Must be one of the themes that can be used in code{shinythemes::shinytheme()}
#' @param height Height of the printed app. Used for code{rmd = TRUE}, otherwise ignored
#' @param css Path to a custom css file. If code{NULL} the default css file is used 
#' @param ... Additional arguments passed to code{shiny::runApp()} 
#'  
#' @details When publishing apps using shinyapps.io or shinyServer, setting code{pub = TRUE} prevents calls to code{install.packages}. Calls to code{install.packages} should not be included within an app and will result in an error.
#' 
#' @export 

gadget_lm <- function(data,xvar, yvar, theme = "flatly", 
                      width = '100%', css = NULL, height = '600px',...) {

  do.call('library', args = list('miniUI'))
  do.call('library', args = list('ggplot2'))

ui <- miniPage(
    
  gadgetTitleBar("Interactive Regression App"),
    miniContentPanel(
      fillRow(flex = c(NA, 1),
        fillCol(width = "100px",
          selectInput("degree", 
                      "Polynomial degree", 
                      c(1, 2, 3, 4))),
        
         plotOutput("plot1",
                    height = "100%", 
                    click = "plot1_click",
                    brush = brushOpts(id = "plot1_brush")))),
    
    miniButtonBlock(
      actionButton("exclude_toggle", "Toggle points"),
      actionButton("exclude_reset", "Reset")))

server <- function(input, output) {
    # For storing which rows have been excluded
    vals <- reactiveValues( keeprows = rep(TRUE, nrow(data)) )

output$plot1 <- renderPlot({
      req(input$degree)
      formula <- as.formula(paste0("y ~ poly(x, degree = ", input$degree, ")"))

      # Plot the kept and excluded points as two separate data sets
      keep    <- data[ vals$keeprows, , drop = FALSE]
      exclude <- data[!vals$keeprows, , drop = FALSE]

      ggplot2::ggplot(keep, 
             ggplot2::aes_string(xvar, yvar)) + 
             ggplot2::geom_point() +
             ggplot2::geom_smooth(method = lm, 
                         formula = formula, 
                         fullrange = TRUE, 
                         color = "gray50") +
             ggplot2::geom_point(data = exclude, 
                        fill = NA, 
                        color = "black", 
                        alpha = 0.25) +
             ggplot2::coord_cartesian(xlim = range(data[[xvar]]), 
                             ylim = range(data[[yvar]])) +
             ggplot2::theme_bw(base_size = 14)
})

# Toggle points that are clicked
observeEvent(input$plot1_click, {
      
  res <- nearPoints(data, input$plot1_click, allRows = TRUE)

  vals$keeprows <- xor(vals$keeprows, res$selected_)
})

# Toggle points that are brushed, when button is clicked
observeEvent(input$exclude_toggle, {

  res <- brushedPoints(data, input$plot1_brush, allRows = TRUE)

  vals$keeprows <- xor(vals$keeprows, res$selected_)
})

# Reset all points
observeEvent(input$exclude_reset, {

  vals$keeprows <- rep(TRUE, nrow(data))
})

# Handle the Done button being pressed.
observeEvent(input$done, {
  
# Replace x and y in the formula with the values in xvar and yvar
  formula <- as.formula(paste0(yvar, 
                               " ~ poly(", 
                               xvar, 
                               ", degree = ",
                               input$degree, 
                               ")"))
  
  keep_data <- data[vals$keeprows, , drop = FALSE]

# Return the kept points.
stopApp(list(data = keep_data,
             model = lm(formula, keep_data)))
})
}
  runGadget(ui, server, viewer = dialogViewer("gadget_lm"))
}

