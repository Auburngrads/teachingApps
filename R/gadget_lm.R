#' Function Title
#'
#' @description Description
#'
#' @import shinythemes
#' @import miniUI
#' @importFrom shiny fixedPanel uiOutput HTML htmlOutput sidebarLayout renderUI titlePanel
#' @importFrom shiny brushedPoints brushOpts br hr checkboxInput div
#' @importFrom shiny fixedPanel uiOutput HTML htmlOutput sidebarLayout tags renderUI tags
#' @importFrom shiny sidebarPanel mainPanel fluidPage navbarPage tabPanel
#' @importFrom shiny tabsetPanel withMathJax updateSelectInput updateSliderInput
#' @importFrom shiny updateNumericInput strong stopApp shinyAppDir req
#' @importFrom shiny radioButtons clickOpts runApp helpText h1 h5 h6 includeCSS
#' @importFrom shiny includeScript includeMarkdown inputPanel isolate nearPoints
#' @importFrom shiny observe observeEvent reactiveValues reactive renderText
#' @importFrom shiny runGadget dialogViewer browserViewer
#' @importFrom stats as.formula lm
#' @importFrom ggplot2 aes_string geom_point geom_smooth theme_bw coord_cartesian ggplot
#'
#' @param data A \code{data.frame} object
#' @param xvar Column title (as a \code{character}-string) from \code{data} to display on the x-axis
#' @param yvar Column title (as a \code{character}-string) from \code{data} to display on the y-axis
#' @param theme \code{character} string naming a color theme bootswatch color theme. Must be one of the themes that can be used in \code{shinythemes::shinytheme()}
#' @param height Height of the printed app.
#' @param width Width of the printed app.
#' @param css Path to a custom css file. If \code{NULL} the default css file is used 
#' @param ... Additional options passed to \code{shiny::shinyAppDir()} 
#'  
#' @export 
gadget_lm <- 
function(data, xvar, yvar, theme = "flatly", 
         width = '100%', css = NULL, height = '600px',...) 
{
  
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
server <- 
function(input, output) {
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
