berkson_interval <-
function(...) {
  
  loadNamespace('shiny')
  loadNamespace('SMRD')
  
shinyApp(options = list(height = '600px', width = '100%'),
    
    ui = fluidPage(theme = shinythemes::shinytheme('flatly'), 
                   includeCSS('css/my-shiny.css'),
         sidebarLayout(
           sidebarPanel(width = 4,
             shinyAce::aceEditor("berkint", 
                                 mode = "r", 
                                 theme = "github", 
                                 height = "450px", 
                                 fontSize = 16,
                                 value = "
par(family = 'serif', mfrow = c(1,2), las = 1, cex = 1.25)

loadNamespace('SMRD')

zoom <- 1.5

Berkson200.ld <- 
frame.to.ld(SMRD:::datas$berkson200,
            response.column = c(1,2), 
            censor.column = 3,
            case.weight.column = 4,
            time.units = 'Kilometers')

simple.contour(Berkson200.ld, 
               distribution = 'exponential', 
               xlim = c(400,800),
               original.par = F)

simple.contour(Berkson200.ld, 
               distribution = 'weibull', 
               show.confidence = F, 
               zoom.level = zoom)

par(mfrow = c(1,1))"),

        actionButton("berks", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("berkint", height = "600px"), width = 8))),

server = function(input, output, session) {

  loadNamespace('SMRD')
    
  output$berkint <- renderPlot({
      input$berks
      return(isolate(eval(parse(text=input$berkint))))
})
})
}
