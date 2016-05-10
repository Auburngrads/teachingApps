shockabsorber_profiles <-
function(...) {
  
  loadNamespace('shiny')
  loadNamespace(SMRD)
  
shinyApp(options = list(height = '600px', width = '99%'),
    
    ui = fluidPage(theme = shinythemes::shinytheme('flatly'), 
                   includeCSS('css/my-shiny.css'),
         sidebarLayout(
           sidebarPanel(
             shinyAce::aceEditor("shockprof", 
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
               profile = 'x', 
               size = 300,
               print.ci = F)

simple.contour(ShockAbsorber.ld, 
               distribution = 'weibull', 
               profile = 'y', 
               size = 300,
               print.ci = F)

par(mfrow = c(1,1))"),
actionButton("shockprofs", h4("Evaluate")), width = 4),
        
        mainPanel(plotOutput("shorf", height = "600px"), width = 8))),

server = function(input, output, session) {

  loadNamespace(SMRD)
    
  output$shorf <- renderPlot({
      input$shockprofs
      return(isolate(eval(parse(text=input$shockprof))))
})
})
}
