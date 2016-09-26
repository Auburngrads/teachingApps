library(pos = -1,  package = 'SMRD')











load('args.Rdata')
shinyApp(options = list(width = "100%", height = "600px"),
         
ui = fluidPage(theme = shinythemes::shinytheme(theme = arg2$theme), 
               try(includeCSS(system.file('css',
                                          'my-shiny.css', 
                                          package = 'teachingApps')), silent = TRUE),
  sidebarLayout( 
    sidebarPanel(
      shinyAce::aceEditor(fontSize = 16, 
                                     wordWrap = T,
                                     outputId = "fig1plot", 
                          mode = "r", 
                          theme = "github", 
                          height = "450px",
                         value = 
"par(family='serif',font=2)

library(pos = -1,  package = SMRD)

distribution.plot('Weibull',
shape=c(1.7), ## Change this value or add more
scale=c(1),   ## Change this value or add more
prob.range=c(.000001,.99),
my.title='')"),

        actionButton("evalfig1", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("plotfig1", height = "600px"))),

fixedPanel(htmlOutput('sign'),bottom = '9%', right = '50%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp(basename(getwd())))})
  


output$plotfig1 <- renderPlot({
      input$evalfig1
      return(isolate(eval(parse(text=input$fig1plot))))
})
})
