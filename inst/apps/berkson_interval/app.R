library( package = 'SMRD')










  
get('arg2', envir = .GlobalEnv, inherits = T)

shinyApp(options = list(height = '600px', width = '100%'),
    
ui = fluidPage(theme = shinythemes::shinytheme(theme = arg2$theme), 
               try(includeCSS(system.file('css',
                                          'my-shiny.css', 
                                          package = 'teachingApps')), silent = TRUE),
     sidebarLayout(
        sidebarPanel(width = 4,
           shinyAce::aceEditor(fontSize = 16, 
                               wordWrap = T,
                               outputId = "berkint", 
                               mode = "r", 
                               theme = "github", 
                               height = "450px", 
                               value = "
par(family = 'serif', mfrow = c(1,2), las = 1, cex = 1.25)

library( package = SMRD)

zoom <- 1.5

Berkson200.ld <- 
frame.to.ld(SMRD::berkson200,
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
        
        mainPanel(plotOutput("berkint", height = "600px"), width = 8)),

fixedPanel(htmlOutput('sign'),bottom = '3%', right = '40%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp(arg2$appName))})
  
observeEvent(input$berks, {
     
  output$berkint <- renderPlot({
      
      return(isolate(eval(parse(text=input$berkint))))
})
})
})
