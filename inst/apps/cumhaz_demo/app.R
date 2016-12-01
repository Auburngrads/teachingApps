library(teachingApps)














shinyApp(options = list(height = "800px"),
         onStart = function() { options('markdown.HTML.stylesheet' = system.file('css','my-shiny.css', package = 'teachingApps'))},
         
ui = navbarPage(collapsible = T, 
                position = 'fixed-top',
                title = 'Cumulative Hazard Function',
                theme = shinythemes::shinytheme(theme = global$theme),
                header = tags$head(includeCSS(system.file('css', 'my-shiny.css', package = 'teachingApps'))),
                footer = HTML(teachingApps::teachingApp(global$appName)),
                  
tabPanel(h4('Properties'),
         mainPanel(uiOutput('HAZdemo'), class = 'shiny-text-output', width = 12)),

tabPanel(h4('Computing Values in R'),
         mainPanel(uiOutput('HAZr'), class = 'shiny-text-output', width = 12)),

tabPanel(h4('Shiny App'),                 
   sidebarLayout( 
      sidebarPanel(
          shinyAce::aceEditor(fontSize = 16, 
                              wordWrap = T,
                              outputId = "HAZplot", 
                              mode = "r", 
                              theme = "github", 
                              height = "450px", 
                              value = 
"par(family = 'serif',mar = c(4,6,2,1))
                
curve(
-log(1-pgamma(x, shape = 3, rate = 1.5)),
xlab = 'Time, t',
ylab = expression(H(t)[Gamma]),
ylim = c(0,1),
xlim = c(0,6),
lwd = 3,
lty = 5,
col = 6,
cex.lab = 1.5,
cex.axis = 1.5,
las = 1)"),
                              
        actionButton("evalHAZ", h4("Evaluate"), width = '100%')),
                            
        mainPanel(plotOutput("plotHAZ", height = "600px"))))),
           
server = function(input, output, session) {

output$HAZdemo <- renderUI({ 
  withMathJax(HTML(includeMarkdown('backgroundchaz.Rmd')))
})

output$HAZr <- renderUI({ 
  withMathJax(HTML(includeMarkdown('rfuncschaz.Rmd')))
})

observeEvent(input$evalHAZ, { 
              
output$plotHAZ <- renderPlot({

  return(isolate(eval(parse(text=input$HAZplot))))
})
})
})
