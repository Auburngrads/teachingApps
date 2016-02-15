figure1_1 <-
function(...) {
  
  library(shiny)
  
shinyApp(options = list(width = "99%", height = "800px"), 
ui = navbarPage(theme = shinythemes::shinytheme("flatly"), includeCSS('css/my-shiny.css'),

tabPanel(h4("Data Set"), DT::dataTableOutput("lzbearing", height = "600px")),
                
tabPanel(h4("Figure 1.1"),titlePanel("Use this code to reproduce the histogram in Figure 1.1. Input changes and click 'Evaluate'"),
  sidebarLayout( 
    sidebarPanel(width = 5,
      shinyAce::aceEditor("fig1plot", mode = "r", theme = "github", height = "450px", fontSize = 15,
                      value = "library(SMRD)
par(family='serif', font=2)
hist(lzbearing$megacycles,
     breaks=seq(0,200,20),
     col='black',
     border='white',
     prob=TRUE,
     main='Figure 1.1 - Histogram of the ball bearing failure data',
     las = 1)"),
              actionButton("evalfig1", h4("Evaluate"))),
        
        mainPanel(plotOutput("plotfig1", height = "550px"), width = 7))),

tabPanel(h4("Figure 1.2"),titlePanel("Use this code to reproduce the event plot in Figure 1.2. Input changes and click 'Evaluate'"),
  sidebarLayout( 
    sidebarPanel(width = 5,
      shinyAce::aceEditor("fig2plot", mode = "r", theme = "github", height = "450px", fontSize = 15,
                      value = "library(SMRD)
par(family='serif', font=2)

lzbearing.ld <- frame.to.ld(lzbearing, 
                            response.column = 1, 
                            time.units = 'Megacycles')

event.plot(lzbearing.ld)"),
              actionButton("evalfig2", h4("Evaluate"))),
        
        mainPanel(plotOutput("plotfig2", height = "550px"), width = 7)))),

server = function(input, output, session) {
  library(SMRD)
  output$lzbearing <- DT::renderDataTable({ DT::datatable(lzbearing,
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
}
