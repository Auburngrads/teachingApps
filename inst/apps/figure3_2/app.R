library(pos = -1,  package = 'SMRD')










  
load('args.Rdata')
shinyApp(options = list(height = '600px', width = '100%'),
    ui = fluidPage(theme = shinythemes::shinytheme(theme = arg2$theme), 
                   try(includeCSS(system.file('css',
                                              'my-shiny.css', 
                                              package = 'teachingApps')), silent = TRUE),
    sidebarLayout(
      sidebarPanel(
        shinyAce::aceEditor(fontSize = 16, 
                                     wordWrap = T,
                                     outputId = "npplot", 
                            mode = "r", 
                            theme = "github", 
                            height = "475px", 
                            
                            value = 
"par(family = 'serif', font = 2, cex = 1.15)

library(pos = -1,  package = SMRD)

HE.ld <- frame.to.ld(SMRD::heatexchanger,
                     response.column = c(1,2), 
                     censor.column = 3,
                     case.weight.column = 4,
                     time.units = 'Years')

plot(HE.ld,band.type = 'Pointwise')"),

        actionButton("eval3.2", h4("Evaluate"),width = '100%')),
        
        mainPanel(plotOutput("plot3.2", height = "600px"))),

fixedPanel(htmlOutput('sign'),bottom = '9%', right = '50%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp(basename(getwd())))})
  


output$plot3.2 <- renderPlot({
      input$eval3.2
      return(isolate(eval(parse(text=input$npplot))))
})
})
