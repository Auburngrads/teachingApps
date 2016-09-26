











load('args.Rdata')
shinyApp(options = list(width = "100%", height = "600px"),
ui = fluidPage(theme = shinythemes::shinytheme(theme = arg2$theme), 
              try(includeCSS(system.file('css','my-shiny.css', 
                                         package = 'teachingApps')), silent = TRUE), 
                
  sidebarLayout( 
    sidebarPanel(
      shinyAce::aceEditor("fig1plot", 
                          mode = "r", 
                          theme = "github", 
                          height = "450px",
                          value = 
"par(mar = c(0,0,0,0))
plot(NA, 
     xlim = range(0,500), 
     ylim = range(25,525), 
     axes = FALSE, 
     xlab = '', 
     ylab = '')

points(x = 250, 
       y = 250, 
       col = 'green', 
       cex = 13, 
       lwd = 4, 
       pch = 16)

text(x = c(100,250,400), 
     y = c(475,250,475),
     labels = c(expression(underline('  Producers  ')),
                '$', 
                expression(underline('  Consumers  '))),
     cex = c(4, 6, 4), 
     font = 2, 
     col = c(1, 0, 1))

text(x = rep(100, 5), 
     y = seq(425, 75, -75), 
     labels = c('Quick to Market',
                'Minimize Warranty Costs',
                'Reduce LCC',
                'Reduce Liability Costs', 
                'Maintain Market Share'),  
     cex = rep(2.5, 5), 
     family = 'serif')

text(x = rep(400, 5), 
     y = seq(425, 75, -75), 
     labels = c('Newer Capabilities', 
                'Improve Current Functions',
                'Merge Functions',
                'Expect High Performance',
                'Expect to Last'), 
     cex = rep(2.5,5), 
     family = 'mono')"),

        actionButton("evalenvir", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("plotenvir", height = "600px"))),

fixedPanel(htmlOutput('sign'),bottom = '9%', right = '50%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp(basename(getwd())))})
  

  
  output$plotenvir <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4,4,2,2))
      input$evalenvir
      return(isolate(eval(parse(text=input$fig1plot))))
})
})
