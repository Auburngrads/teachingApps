figure2.1 <-
function(...) {

library(shiny)
library(shinyAce)
library(shinythemes)
  
shinyApp(options = list(width = "100%", height = "800px"),
ui = fluidPage(theme = shinytheme("flatly"), includeCSS('css/my-shiny.css'),
titlePanel("Input changes and click 'Evaluate' to edit Figure 2.1"),
  sidebarLayout( 
    sidebarPanel(
      aceEditor("fig1plot", mode = "r", theme = "github", height = "450px",
                      value = "par(family='serif',font=2)

library(SMRD)

distribution.plot('Weibull',
shape=c(1.7), ## Change this value or add more
scale=c(1),   ## Change this value or add more
prob.range=c(.000001,.99),
my.title='')"),
              actionButton("evalfig1", h4("Evaluate"))),
        
        mainPanel(plotOutput("plotfig1", height = "600px")))),
server = function(input, output, session) {
  library(SMRD)

output$plotfig1 <- renderPlot({
      input$evalfig1
      return(isolate(eval(parse(text=input$fig1plot))))
})
})
}
