figure1_9 <-
function(...) {
  
 try(attachNamespace('shiny'), silent = TRUE)
 try(attachNamespace('SMRD'), silent = TRUE)
  
shinyApp(options = list(width = "100%", height = "800px"),
         
ui = navbarPage(theme = shinythemes::shinytheme("flatly"), 
                try(includeCSS(system.file('css',
                                           'my-shiny.css', 
                                           package = 'teachingApps')), silent = TRUE),

tabPanel(h4("Data Set"), DT::dataTableOutput("printedcircuitboard", height = "600px")),
                
tabPanel(h4("Figure 1.9"),
  sidebarLayout( 
    sidebarPanel(width = 5,
      shinyAce::aceEditor("fig9plot", 
                          mode = "r", 
                          theme = "github", 
                          height = "450px",
                          value = 
"par(family= 'serif', font=2)

plot(hoursl~rh, 
     data = SMRD::printedcircuitboard,
     pch = 'X', cex = .85, log = 'y',
     ylim = c(10,10000),xlim = c(45,85))

text(x = c(50,63,75,82), 
     y = c(7000,6000,1000,350), 
     labels c('48/70 censored',
              '11/68 censored',
              '0/70 censored',
              '0/70 censored'))"),

        actionButton("evalfig9", h4("Evaluate"), width = '100%')),
        
        mainPanel(plotOutput("plotfig9", height = "600px"), width = 7))),

fixedPanel(htmlOutput('sign'),bottom = '1%', right = '1%', height = '30px')),

server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApp('acceptance_mtbf'))})
  


  output$printedcircuitboard <- DT::renderDataTable({ DT::datatable(SMRD::printedcircuitboard,
                                                       options = list(pageLength = 12)) })
  
  output$plotfig9 <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4,4,2,2))
      input$evalfig9
      return(isolate(eval(parse(text=input$fig9plot))))
})
})
}
