library(teachingApps)
library('SMRD')










  


shinyApp(options = list(height = "800px"),
         onStart = function() { options('markdown.HTML.stylesheet' = system.file('css','my-shiny.css', package = 'teachingApps'))},
         
ui = navbarPage(position = 'fixed-top',
                collapsible = T, 
                title = 'Example 1.8',
                theme = shinythemes::shinytheme(theme = getShinyOptions("theme")),
                header = tags$head(includeCSS(system.file('css', 'my-shiny.css', package = 'teachingApps'))),
                footer = HTML(teachingApps::teachingApp(getShinyOptions("appName"))),

tabPanel(h4('Background'),
         mainPanel(uiOutput('example1.8'), class = 'shiny-text-output', width = 12)),
                
tabPanel(h4("Data Set"), 
         titlePanel(HTML('SMRD data object: <code>printedcircuitboard</code>')),
         DT::dataTableOutput("printedcircuitboard", height = "600px")),
                
tabPanel(h4("Figure 1.9"),
  sidebarLayout( 
    sidebarPanel(width = 5,
      shinyAce::aceEditor(fontSize = 16, 
                                     wordWrap = T,
                                     outputId = "fig9plot", 
                          mode = "r", 
                          theme = "github", 
                          height = "450px",
                          value = 
"par(family = 'serif', font = 2)

plot(hoursl~rh, 
     data = SMRD::printedcircuitboard,
     pch = 'X', cex = .85, log = 'y',
     ylim = c(10,10000),xlim = c(45,85))

text(x = c(50,63,75,82), 
     y = c(7000,6000,1000,350), 
     labels = c('48/70 censored',
              '11/68 censored',
              '0/70 censored',
              '0/70 censored'))"),

        actionButton("evalfig9", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("plotfig9", height = "600px"), width = 7)))),

server = function(input, output, session) {
  
output$example1.8 <- renderUI({ 
  withMathJax(HTML(includeMarkdown('background.Rmd')))
})

  output$printedcircuitboard <- DT::renderDataTable({ DT::datatable(SMRD::printedcircuitboard,
                                                       options = list(pageLength = 10)) })
  
  output$plotfig9 <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4,4,2,2))
      input$evalfig9
      return(isolate(eval(parse(text=input$fig9plot))))
})
})
