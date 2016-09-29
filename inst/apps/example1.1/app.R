library(pos = -1,  package = 'SMRD')










  
load('args.Rdata')
shinyApp(options = list(width = "100%", height = "800px"), 
ui = navbarPage(theme = shinythemes::shinytheme(theme = arg2$theme), 
                try(includeCSS(system.file('css',
                                           'my-shiny.css', 
                                           package = 'teachingApps')), silent = TRUE),
tabPanel(h4('Background'),
         mainPanel(uiOutput('example1.1'), class = 'shiny-text-output', width = 12)),
                
tabPanel(h4("Table 1.1"), DT::dataTableOutput("lzbearing", height = "600px")),
                
tabPanel(h4("Figure 1.1"),
  sidebarLayout( 
    sidebarPanel(width = 5,
      shinyAce::aceEditor(fontSize = 16, 
                                     wordWrap = T,
                                     outputId = "fig1plot", 
                          mode = "r", 
                          theme = "github", 
                          height = "450px", 
                          
                          value = "
library(pos = -1,  package = SMRD)
par(family='serif', font=2)
hist(SMRD::lzbearing$mcycles,
     breaks=seq(0,200,20),
     col='black',
     border='white',
     prob=TRUE,
     main='Figure 1.1 - Histogram of the ball bearing failure data',
     las = 1)"),
      
        actionButton("evalfig1", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("plotfig1", height = "600px"), width = 7))),

tabPanel(h4("Figure 1.2"),
  sidebarLayout( 
    sidebarPanel(width = 5,
      shinyAce::aceEditor(fontSize = 16, 
                                     wordWrap = T,
                                     outputId = "fig2plot", 
                          mode = "r", 
                          theme = "github", 
                          height = "450px", 
                          
                          value = 
"library(pos = -1,  package = SMRD)
par(family='serif', font=2)

lzbearing.ld <- frame.to.ld(SMRD::lzbearing, 
                            response.column = 1, 
                            time.units = 'Megacycles')

event.plot(lzbearing.ld)"),

        actionButton("evalfig2", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("plotfig2", height = "600px"), width = 7))),

fixedPanel(htmlOutput('sign'),bottom = '3%', right = '40%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp(basename(getwd())))})

output$example1.1 <- renderUI({ 
  withMathJax(HTML(includeMarkdown('background.Rmd')))
})
  
output$lzbearing <- DT::renderDataTable({ DT::datatable(SMRD::lzbearing,
                                                       options = list(pageLength = 12)) })
  
output$plotfig1 <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4,4,2,2))
      input$evalfig1
      return(isolate(eval(parse(text=input$fig1plot))))
})
output$plotfig2 <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4,4,2,2))
      input$evalfig2
      return(isolate(eval(parse(text=input$fig2plot))))
})
})
