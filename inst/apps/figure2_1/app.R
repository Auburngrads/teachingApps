library(package = 'SMRD')











load('args.Rdata')
shinyApp(options = list(width = "100%", height = "600px"),
         
ui = fluidPage(theme = shinythemes::shinytheme(theme = arg2$theme), 
               try(includeCSS(system.file('css',
                                          'my-shiny.css', 
                                          package = 'teachingApps')), silent = TRUE),
  sidebarLayout( 
    sidebarPanel(width = 5,
      shinyAce::aceEditor(fontSize = 16, 
                          wordWrap = T,
                          outputId = "fig1plot", 
                          mode = "r", 
                          theme = "github", 
                          height = "450px",
                          value = 
"par(family = 'serif',font = 2)

library(package = SMRD)

distribution.plot('Weibull',
                  shape = c(1.7), 
                  scale = 1,
                  prob.range=c(.000001,.99))"),

        actionButton("evalfig1", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("plotfig1", height = "600px"), width = 7)),

fixedPanel(htmlOutput('sign'),bottom = '3%', right = '40%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp(basename(getwd())))})

  observeEvent(input$evalfig1, { 
    
output$plotfig1 <- renderPlot({
      
      return(isolate(eval(parse(text=input$fig1plot))))
})
})
})
