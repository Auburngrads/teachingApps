











load('args.Rdata')
shinyApp(options = list(width = "100%", height = "600px"),
ui = fluidPage(theme = shinythemes::shinytheme(theme = arg2$theme), 
               try(includeCSS(system.file('css',
                                          'my-shiny.css', 
                                          package = 'teachingApps')), silent = TRUE),  sidebarLayout( 
    sidebarPanel(
      shinyAce::aceEditor(fontSize = 16, 
                                     wordWrap = T,
                                     outputId = "pdfplot", 
                          mode = "r", 
                          theme = "github", 
                          height = "450px", 
                          
                          value = 
"par(family='serif',mar = c(4,6,2,1))

curve(dexp(x,rate = 1.7),
      xlab = 'Time, t',
      ylab = expression(f(t)[Exponential]),
      xlim = c(0,3),
      lwd = 3,
      lty = 2,
      col = 3,
      cex.lab = 1.5,
      cex.axis = 1.5,
      las = 1)"),

        actionButton("evalpdf", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("plotpdf", height = "600px"))),

fixedPanel(htmlOutput('sign'),bottom = '3%', right = '40%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp(basename(getwd())))})
  


output$plotpdf <- renderPlot({
      input$evalpdf
      return(isolate(eval(parse(text=input$pdfplot))))
})
})
