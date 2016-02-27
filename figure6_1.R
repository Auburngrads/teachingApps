figure6_1 <-
function(...) {
  
  library(shiny)
  
shinyApp(options = list(width = "100%", height = "600px"), 
ui = fluidPage(theme = shinythemes::shinytheme("flatly"),includeCSS('css/my-shiny.css'),
  sidebarLayout( 
    sidebarPanel(
      shinyAce::aceEditor("plots", mode = "r", theme = "github", height = "450px",
                      value = "par(family='serif',font=2, cex=1.75)
p <- seq(.01,.99,.01)
gamma1 <- 0
theta1 <- 50

gamma2 <- 0
theta2 <-200

plot(qexp(p,rate=1/theta1) - gamma1,-log(1-p),
     type='l', las = 1,
     lwd=2, col=1,
     xlim=range(0,800),
     xlab='Time',
     ylab='Standard Exponential Quantile')

lines(qexp(p,rate=1/theta2) - gamma2, -log(1-p),
      lwd=2, col=2)

text(c(100,650),c(4,2.5), 
     c(expression(theta*', '*gamma*' = 50, 0'),
       expression(theta*', '*gamma*' = 200, 0')))
box(lwd=1.25)"),
              actionButton("evalplots", h4("Evaluate"))),
        
        mainPanel(plotOutput("exp", height = "600px")))),

server = function(input, output, session) {
  
  output$exp <- renderPlot({
      par(mar = c(4,4,2,2))
      input$evalplots
      return(isolate(eval(parse(text=input$plots))))
})
})
}
