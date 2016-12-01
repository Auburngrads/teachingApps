library(teachingApps)
library('SMRD')










  


shinyApp(options = list(height = "600px"),
         onStart = function() { options('markdown.HTML.stylesheet' = system.file('css','my-shiny.css', package = 'teachingApps'))},
    
    ui = fluidPage(theme = shinythemes::shinytheme(theme = global$theme), 
                tags$head(includeCSS(system.file('css', 'my-shiny.css', package = 'teachingApps'))),
         sidebarLayout(
           sidebarPanel(width = 4,
             shinyAce::aceEditor(fontSize = 16, 
                                     wordWrap = T,
                                     outputId = "shockprof", 
                                 mode = "r", 
                                 theme = "github", 
                                 height = "450px", 
                                 
                                 value = "
par(family = 'serif', mfrow = c(1,2), las = 1, cex = 1.25)

library(SMRD)

ShockAbsorber.ld <- 
frame.to.ld(SMRD::shockabsorber,
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
             
        actionButton("shockprofs", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("shorf", height = "600px"), width = 8)),

fixedPanel(htmlOutput('sign'),bottom = '3%', right = '40%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp(global$appName))})
  


  output$shorf <- renderPlot({
      input$shockprofs
      return(isolate(eval(parse(text=input$shockprof))))
})
})
