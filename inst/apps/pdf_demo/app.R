











load('args.Rdata')
shinyApp(options = list(width = "100%", height = "800px"),
         
ui = navbarPage(collapsible = T, 
                title = 'Density Function',
                theme = shinythemes::shinytheme(theme = arg2$theme),
                header = tags$head(includeCSS(system.file('css', 'my-shiny.css', package = 'teachingApps'))),
                footer = HTML(teachingApps::teachingApp(basename(getwd()))),
                
tabPanel(h4('Properties'),
         mainPanel(uiOutput('pdfdemo'), class = 'shiny-text-output', width = 12)),

tabPanel(h4('Computing Values in R'),
         mainPanel(uiOutput('pdfr'), class = 'shiny-text-output', width = 12)),
                    
tabPanel(h4('Shiny App'),
  sidebarLayout(
    sidebarPanel(
      shinyAce::aceEditor(fontSize = 16, 
                          wordWrap = T,
                          outputId = "pdfplot", 
                          mode = "r", 
                          theme = "github", 
                          height = "450px", 
                          value = 
"par(family = 'serif',mar = c(4,6,2,1))

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
        
        mainPanel(plotOutput("plotpdf", height = "600px"))))),

server = function(input, output, session) {
  
output$pdfdemo <- renderUI({ 
  withMathJax(HTML(includeMarkdown('background.Rmd')))
})

output$pdfr <- renderUI({ 
  withMathJax(HTML(includeMarkdown('rfuncs.Rmd')))
})

output$plotpdf <- renderPlot({
      input$evalpdf
      return(isolate(eval(parse(text=input$pdfplot))))
})
})
