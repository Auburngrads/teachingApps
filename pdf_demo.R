pdf_demo <-
function(...) {
  
library(shiny)

shinyApp(options = list(width = "100%", height = "600px"),
ui = fluidPage(theme = shinythemes::shinytheme("flatly"), includeCSS('css/my-shiny.css'),  sidebarLayout( 
    sidebarPanel(
      shinyAce::aceEditor("pdfplot", mode = "r", theme = "github", height = "450px", fontSize = 15,
                      value = "par(family='serif',mar = c(4,6,2,1))

curve(
dexp(x,rate = 1.7),
xlab = 'Time, t',
ylab = expression(f(t)[Exponential]),
xlim = c(0,3),
lwd = 3,
lty = 2,
col = 3,
cex.lab = 1.5,
cex.axis = 1.5,
las = 1)"),
              actionButton("evalpdf", h4("Evaluate"))),
        
        mainPanel(plotOutput("plotpdf", height = "600px")))),
server = function(input, output, session) {

output$plotpdf <- renderPlot({
      input$evalpdf
      return(isolate(eval(parse(text=input$pdfplot))))
})
})
}
