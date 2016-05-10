shockabsorber_probabilities <-
function(...) {
  
  loadNamespace(shiny)
  loadNamespace(SMRD)
  
shinyApp(options = list(height = '600px', width = '99%'),
    
    ui = fluidPage(theme = shinythemes::shinytheme('flatly'), 
                   includeCSS('css/my-shiny.css'),
         sidebarLayout(
           sidebarPanel(
             shinyAce::aceEditor("shockprob", 
                                 mode = "r", 
                                 theme = "github", 
                                 height = "450px", 
                                 fontSize = 16,
                                 value = "
par(family = 'serif', mfrow = c(1,2), las = 1, cex = 1.25)

loadNamespace(SMRD)

ShockAbsorber.ld <- 
frame.to.ld(shockabsorber,
            response.column = 1, 
            censor.column = 3,
            time.units = 'Kilometers')

simple.contour(ShockAbsorber.ld, 
               distribution = 'weibull', 
               the.quantile = 0.1, 
               size = 300, 
               factor = 2.25, 
               rel.or.conf = 'Relative likelihood',
               original.par = F)

simple.contour(ShockAbsorber.ld, 
               distribution = 'weibull', 
               the.quantile = 0.1, 
               profile = 'x', 
               size = 300)

par(mfrow = c(1,1))"),
actionButton("shockprobs", h4("Evaluate")), width = 4),
        
        mainPanel(plotOutput("sprob", height = "600px"), width = 8))),

server = function(input, output, session) {

  loadNamespace(SMRD)
    
  output$sprob <- renderPlot({
      input$shockprobs
      return(isolate(eval(parse(text=input$shockprob))))
})
})
}
