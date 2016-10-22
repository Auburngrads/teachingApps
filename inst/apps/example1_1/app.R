library(teachingApps)
library('SMRD')










  


shinyApp(options = list(width = "100%", height = "800px"), 
ui = navbarPage(position = 'fixed-top',
                collapsible = T, 
                title = 'Example 1.1',
                theme = shinythemes::shinytheme(theme = source('www/args.R')[[1]]$theme),
                header = tags$head(includeCSS(system.file('css', 'my-shiny.css', package = 'teachingApps'))),
                footer = HTML(teachingApps::teachingApp(source('www/args.R')[[1]]$appName)),
                
tabPanel(h4('Background'),
         mainPanel(uiOutput('example1.1'), class = 'shiny-text-output', width = 12)),
                
tabPanel(h4("Table 1.1"), 
         titlePanel(HTML('SMRD data object: <code>lzbearing</code>')),
         DT::dataTableOutput("lzbearing", height = "600px")),

navbarMenu(h4('Figures'), icon = icon('bar-chart-o'),       
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
library(SMRD)

par(family = 'serif', font = 2)

hist(SMRD::lzbearing$mcycles,
     breaks = seq(0,200,20),
     col = 'black',
     border = 'white',
     prob = TRUE,
     main = 'Figure 1.1 - Histogram of the ball bearing failure data',
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
"library(SMRD)

par(family='serif', font=2)

lzbearing.ld <- frame.to.ld(SMRD::lzbearing, 
                            response.column = 1, 
                            time.units = 'Megacycles')

event.plot(lzbearing.ld)"),

        actionButton("evalfig2", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("plotfig2", height = "600px"), width = 7))))),

server = function(input, output, session) {
  
output$example1.1 <- renderUI({ 
  withMathJax(HTML(includeMarkdown('background.Rmd')))
})
  
output$lzbearing <- DT::renderDataTable({ DT::datatable(SMRD::lzbearing,
                                                       options = list(pageLength = 10)) })
  
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
