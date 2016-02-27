exp_mle <-
function(...) {
  
  library(shiny)
  
shinyApp(options = list(height = '600px', width = '99%'),
  
  ui = fluidPage(theme = shinythemes::shinytheme('flatly'), includeCSS('css/my-shiny.css'),
    sidebarLayout(
      sidebarPanel(
        shinyAce::aceEditor("mlexpplot", mode = "r", theme = "github", height = "450px",
                      value = "par(font = 2, mar = c(4,5.5,1,1), family = 'serif', cex = 1.5)
obs <- c(4.2564, 0.5319)
theta <- seq(0.25, 10, .05)
joint.prob.exp <- dexp(obs[1], rate = 1/theta)*dexp(obs[2], rate = 1/theta)

plot(theta, joint.prob.exp, 
     xlab = expression(widehat(theta)[MLE]),
     ylab = expression(prod(t[i],i=1,2)),
     type = 'l', las = 1, lwd = 3, col = 2)
abline(v = sum(obs)/2, lwd = 2, lty = 2)
text(sum(obs)/2, .005,
     labels = parse(text = paste(c(expression('' %<-% ''), 
                                   sum(obs)/2), collapse = '~')),
      adj = 0)"),
actionButton("mlexpplots", h4("Evaluate"))),
        
        mainPanel(plotOutput("mlexp", height = "600px")))),

server = function(input, output, session) {
  
  output$mlexp <- renderPlot({
      input$mlexpplots
      return(isolate(eval(parse(text=input$mlexpplot))))
})
})
}
