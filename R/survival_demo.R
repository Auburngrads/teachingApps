survival_demo <-
function(...) {
  
library(shiny)
  
shinyApp(options = list(width = "100%", height = "600px"),
ui = fluidPage(theme = shinythemes::shinytheme("flatly"), includeCSS('../css/my-shiny.css'),
  sidebarLayout( 
    sidebarPanel(
      shinyAce::aceEditor("relplot", mode = "r", theme = "github", height = "450px", fontSize = 15,
                      value = "par(family='serif',mar = c(4,6,2,1))

curve(
expr = 1-pnorm(x, mean = 3, sd = 1),
xlab = 'Time, t',
ylab = expression(S(t)[Normal]),
ylim = c(0,1),
xlim = c(0,6),
lwd = 3,
lty = 3,
col = 4,
cex.lab = 1.5,
cex.axis = 1.5,
las = 1)"),
              actionButton("evalrel", h4("Evaluate"))),
        
        mainPanel(plotOutput("plotrel", height = "600px")))),
server = function(input, output, session) {

output$plotrel <- renderPlot({
      input$evalrel
      return(isolate(eval(parse(text=input$relplot))))
})
})
}
