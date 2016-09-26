library(pos = -1,  package = 'SMRD')










  
load('args.Rdata')
shinyApp(options = list(height = '600px', width = '99%'),
    
    ui = fluidPage(theme = shinythemes::shinytheme(theme = arg2$theme), 
                   try(includeCSS(system.file('css',
                                              'my-shiny.css', 
                                              package = 'teachingApps')), silent = TRUE),
         sidebarLayout(
           sidebarPanel(width = 4,
             shinyAce::aceEditor("shockprob", 
                                 mode = "r", 
                                 theme = "github", 
                                 height = "450px", 
                                 fontSize = 16,
                                 value = "
par(family = 'serif', mfrow = c(1,2), las = 1, cex = 1.25)

library(pos = -1,  package = SMRD)

ShockAbsorber.ld <- 
frame.to.ld(SMRD::shockabsorber,
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
             
        actionButton("shockprobs", h4("Evaluate"),width = '100%')),
        
        mainPanel(plotOutput("sprob", height = "600px"), width = 8)),

fixedPanel(htmlOutput('sign'),bottom = '9%', right = '50%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp(basename(getwd())))})
  


  output$sprob <- renderPlot({
      input$shockprobs
      return(isolate(eval(parse(text=input$shockprob))))
})
})
