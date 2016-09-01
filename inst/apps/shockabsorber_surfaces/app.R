teachingApps::getPackage('SMRD')
  
shinyApp(options = list(height = '600px', width = '99%'),
    
    ui = fluidPage(theme = shinythemes::shinytheme('flatly'), 
                   try(includeCSS(system.file('css',
                                              'my-shiny.css', 
                                              package = 'teachingApps')), silent = TRUE),
         sidebarLayout(
           sidebarPanel(width = 4,
             shinyAce::aceEditor("shocksurf", 
                                 mode = "r", 
                                 theme = "github", 
                                 height = "450px", 
                                 fontSize = 16,
                                 value = "
par(family = 'serif', mfrow = c(1,2), las = 1, cex = 1.25)

library(SMRD)

zoom <- 1.5

ShockAbsorber.ld <- 
frame.to.ld(SMRD::shockabsorber,
            response.column = 1, 
            censor.column = 3,
            time.units = 'Kilometers')

simple.contour(ShockAbsorber.ld, 
               distribution = 'weibull', 
               rel.or.conf = 'Joint confidence region', 
               factor = zoom,
               original.par = F)

simple.contour(ShockAbsorber.ld, 
               distribution = 'weibull', 
               rel.or.conf = 'Relative likelihood', 
               factor = zoom)

par(mfrow = c(1,1))"),
             
        actionButton("shocksurfs", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("shurf", height = "600px"), width = 8)),

fixedPanel(htmlOutput('sign'),bottom = '1%', right = '1%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp('acceptance_mtbf'))})
  


  output$shurf <- renderPlot({
      input$shocksurfs
      return(isolate(eval(parse(text=input$shocksurf))))
})
})
