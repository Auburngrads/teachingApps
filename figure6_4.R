figure6_4 <-
function(...) {
  
  library(shiny)
  
shinyApp(options = list(width = "100%", height = "600px"), 
ui = fluidPage(theme = shinythemes::shinytheme("flatly"),includeCSS('css/my-shiny.css'),
  sidebarLayout( 
    sidebarPanel(
      shinyAce::aceEditor("plots", mode = "r", theme = "github", height = "450px",
                      value = "par(family='serif', font=2, cex=1.75)
p<- seq(.01,.99,.01)
mean1 <- 40
sdev1 <- 10
mean2 <- 80
sdev2 <- 5

plot(qnorm(p, mean=mean1, sd=sdev1), qnorm(p),
     type='l',
     lwd=2, col=1,
     xlim=range(0,100),
     las = 1,
     xlab='Time',
     ylab='Standard Normal Quantile')

lines(qnorm(p,mean=mean2, sd=sdev2), qnorm(p), lwd=2, col=2)
abline(h=0, lty=2)

text(c(15, 85), c(-1,-2), 
     c(expression(mu*', '*sigma*' = 40, 10'),
       expression(mu*', '*sigma*' = 80, 5')))
box(lwd=1.25)"),
              actionButton("evalplots", h4(HTML("<b>Evaluate</b>")))),
        
        mainPanel(plotOutput("norm", height = "600px")))),

server = function(input, output, session) {
  
  output$norm <- renderPlot({
      par(mar = c(4,4,2,2))
      input$evalplots
      return(isolate(eval(parse(text=input$plots))))
})
})
}
