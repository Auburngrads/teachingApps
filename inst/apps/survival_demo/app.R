library(teachingApps)














shinyApp(options = list(width = "100%", height = "800px"),
         
ui = navbarPage(collapsible = T, 
                position = 'fixed-top',
                title = 'Survival Function',
                theme = shinythemes::shinytheme(theme = source('www/args.R')[[1]]$theme),
                header = tags$head(includeCSS(system.file('css', 'my-shiny.css', package = 'teachingApps'))),
                footer = HTML(teachingApps::teachingApp(source('www/args.R')[[1]]$appName)),
                
tabPanel(h4('Properties'),
         mainPanel(uiOutput('survdemo'), class = 'shiny-text-output', width = 12)),

tabPanel(h4('Computing Values in R'),
         mainPanel(uiOutput('survr'), class = 'shiny-text-output', width = 12)),
                
tabPanel(h4('ShinyApp'),                
  sidebarLayout( 
    sidebarPanel(
      shinyAce::aceEditor(fontSize = 16, 
                          wordWrap = T,
                          outputId = "relplot", 
                          mode = "r", 
                          theme = "github", 
                          height = "450px", 
                          value = 
"par(family = 'serif',mar = c(4,6,2,1))

curve(
expr = 1-pnorm(x, mean = 3, sd = 1),
xlab = 'Time, t',
ylab = expression(S(t)[Normal]),
ylim = c(0,1),
xlim = c(0,6),
lwd = 3,
lty = 3,
col = 4,
cex.lab = 1.5,
cex.axis = 1.5,
las = 1)"),

        actionButton("evalrel", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("plotrel", height = "600px"))))),

server = function(input, output, session) {
  
output$survdemo <- renderUI({ 
  withMathJax(HTML(includeMarkdown('backgroundsurv.Rmd')))
})

output$survr <- renderUI({ 
  withMathJax(HTML(includeMarkdown('rfuncssurv.Rmd')))
}) 

observeEvent(input$evalrel, { 

output$plotrel <- renderPlot({
      
      return(isolate(eval(parse(text=input$relplot))))
})
})
})
