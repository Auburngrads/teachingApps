figure6_5 <-
function(...) {
  
  library(shiny)
  
shinyApp(options = list(width = "100%", height = "600px"), 
ui = fluidPage(theme = shinythemes::shinytheme("flatly"),includeCSS('css/my-shiny.css'),
  sidebarLayout( 
    sidebarPanel(
      shinyAce::aceEditor("plots", mode = "r", theme = "github", height = "450px",
                      value = "par(family='serif',font=2,cex=1.75, bg = NA)
p<- seq(.01,.99,.01)

plot(qweibull(p,.5,50), -qgumbel(1-p),
     type='l',
     lwd = 2,
     col = 1,
     xlim = c(1,1000),
     las = 1,
     xlab='Time',
     ylab='Standard SEV Quantile',
     log='x')

lines(qweibull(p,0.5,500), 
     -qgumbel(1-p), lwd = 2, col = 2)
lines(qweibull(p,1.0,500), 
     -qgumbel(1-p), lwd = 2, col = 3)
abline(h=0, lty=2)

box(lwd=1.25)
legend('bottomright',
       c(expression(eta*','*beta*' = 50,0.5'),
         expression(eta*','*beta*' = 500,0.5'),
         expression(eta*','*beta*' = 500,1.0')),
       lty = 1,col = c(1:3), lwd = 2, bty = 'n')"),
              actionButton("evalplots", h4(HTML("<b>Evaluate</b>")))),
        
        mainPanel(plotOutput("lnorm", height = "650px")))),

server = function(input, output, session) {
  
  output$lnorm <- renderPlot({
      par(mar = c(4,4,2,2))
      input$evalplots
      return(isolate(eval(parse(text=input$plots))))
})
})
}
