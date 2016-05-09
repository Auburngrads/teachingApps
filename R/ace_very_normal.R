ace_very_normal <-
function(...) {
  
  library(shiny)
  
shinyApp(options = list(height = '600px', width = '99%'),
  
ui = fluidPage(theme = shinythemes::shinytheme('flatly'), 
                 includeCSS('../css/my-shiny.css'),
sidebarLayout(
  sidebarPanel(
    shinyAce::aceEditor("plots", mode = "r", theme = "github", height = "450px",
                      value = "par(family='serif',font=2, cex=1.5)
curve(dnorm(x,mean = 4.256432, sd = 0.25), 
      xlim = c(0,10), 
      lwd = 2, 
      lty = 1, 
      col = 1,
      ylab = 'f(time)',
      xlab = 'time',
      las = 1,
      n = 300)
curve(dnorm(x,mean = 4.256432, sd = 1.0), lwd = 2, lty = 2, col = 2, add = T)
curve(dnorm(x,mean = 4.256432, sd = 2.0), lwd = 2, lty = 3, col = 3, add = T)
curve(dnorm(x,mean = 4.256432, sd = 3.0), lwd = 2, lty = 4, col = 4, add = T)
curve(dnorm(x,mean = 4.256432, sd = 5.0), lwd = 2, lty = 5, col = 5, add = T)
abline(v = 4.256432)
legend(x = 7, y = 1.5,
       legend = c(expression(sigma==0.25),
                  expression(sigma==1.00),
                  expression(sigma==2.00),
                  expression(sigma==3.00),
                  expression(sigma==5.00)),
       lty = 1:5,
       col = 1:5,
       lwd = 2,
       bty = 'n', 
       y.intersp = 0.75)"),
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
