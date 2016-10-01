











load('args.Rdata')
shinyApp(options = list(width = "100%", height = "800px"),
         
ui = navbarPage(windowTitle = 'CDF Demo',
                theme = shinythemes::shinytheme(theme = arg2$theme), 
                try(includeCSS(system.file('css',
                                           'my-shiny.css', 
                                           package = 'teachingApps')), silent = TRUE),

tabPanel(h4('Properties'),
         mainPanel(uiOutput('cdfdemo'), class = 'shiny-text-output', width = 12)),

tabPanel(h4('Computing Values in R'),
         mainPanel(uiOutput('cdfr'), class = 'shiny-text-output', width = 12)),
                                
 tabPanel(h4('Shiny App'),
  sidebarLayout( 
    sidebarPanel(width = 4,
      shinyAce::aceEditor(fontSize = 16, 
                          wordWrap = T,
                          outputId = "cdfplot", 
                          mode = "r", 
                          theme = "github", 
                          height = "450px", 
                          value = 
"par(family = 'serif',mar = c(4,6,2,1))

curve(
pweibull(x,shape = 1.7, scale = 1),
xlab = 'Time, t',
ylab = expression(F(t)[Weibull]),
ylim = c(0,1),
xlim = c(0,3),
lwd = 3,
lty = 1,
col = 2,
cex.lab = 1.5,
cex.axis = 1.5,
las = 1)"),

        actionButton("evalcdf", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("plotcdf", height = "600px"), width = 8))),

        fixedPanel(htmlOutput('sign'),bottom = '3%', right = '40%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp(basename(getwd())))})

output$cdfdemo <- renderUI({ 
  withMathJax(HTML(includeMarkdown('background.Rmd')))
})

output$cdfr <- renderUI({ 
  withMathJax(HTML(includeMarkdown('rfuncs.Rmd')))
})  

output$plotcdf <- renderPlot({
      input$evalcdf
      return(isolate(eval(parse(text=input$cdfplot))))
})
})
