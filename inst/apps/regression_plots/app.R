











load('args.Rdata')
shinyApp(options = list(height = '650px'),
  ui = fluidPage(theme = shinythemes::shinytheme(theme = arg2$theme), 
                 try(includeCSS(system.file('css',
                                            'my-shiny.css', 
                                            package = 'teachingApps')), silent = T),
      sidebarLayout(
        sidebarPanel(width = 5,
          shinyAce::aceEditor(fontSize = 16, 
                                     wordWrap = T,
                                     outputId = "regplot", 
                              mode = "r", 
                              theme = "github", 
                              height = "475px",
                              value = 
"par(mfrow = c(2,2), # Arrange plots in a 2x2 array 
family = 'serif', # Change the font family
mar = c(2.5,4.1,1.5,2.1)) # Change the plot margins

plot(lm(mtcars), which  = 1, las = 1)
plot(lm(mtcars), which  = 2, las = 1)
plot(lm(mtcars), which  = 3, las = 1)
plot(lm(mtcars), which  = 4, las = 1)

par(mfrow = c(1,1)) # Return plot window to a 1x1 array"),

    actionButton("evalreg", h4("Evaluate"), width = '100%')),
        
    mainPanel(plotOutput("plotreg", height = "550px"), width = 7)),

fixedPanel(htmlOutput('sign'),bottom = '9%', right = '50%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp(basename(getwd())))})
  
  output$plotreg <- renderPlot({
    
      par(oma = c(0,0,0,0), mar = c(4,4,2,2))
      input$evalreg
      return(isolate(eval(parse(text=input$regplot))))
})
})
