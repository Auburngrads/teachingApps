figure1_3 <-
function(...) {
  
  if(!isNamespaceLoaded('shiny')) attachNamespace('shiny')
  if(!isNamespaceLoaded('SMRD')) attachNamespace('SMRD')
  
shinyApp(options = list(width = "100%", height = "800px"),
ui = navbarPage(theme = shinythemes::shinytheme("flatly"), 
               try(includeCSS('css/my-shiny.css'), silent = TRUE),

tabPanel(h4("Data Set"), DT::dataTableOutput("lfp1370", height = "575px")),
                
tabPanel(h4('Figure 1.3'), titlePanel("Edit this code and press 'Evaluate' to change the figure"),
  sidebarLayout( 
    sidebarPanel(
      shinyAce::aceEditor("fig3plot", 
                          mode = "r", 
                          theme = "github", 
                          height = "450px", 
                          fontSize = 14,
                          value = 
"IC.ld<-frame.to.ld(frame = SMRD::lfp1370,\nresponse.column = 1,\ncensor.column = 2,\ncase.weight.column = 3,\ndata.title = 'IC Failure Data',\ntime.units = 'Hours')\n\npar(family='serif',font=2,bg=NA)\n\nevent.plot(IC.ld)\n\n\n\n# event.plot( ) is part of the SMRD package\n\n# SMRD commands can only be performed on\n# 'life.data' objects\n\n# frame.to.ld( ) converts a 'data.frame'\n# to a 'life.data' object"),

        actionButton("evalfig3", h4('Evaluate'), width = '100%')),
        
        mainPanel(plotOutput("plotfig3", height = "600px"))))),

server = function(input, output, session) {

  output$lfp1370 <- DT::renderDataTable({ DT::datatable(SMRD::lfp1370,
                                                       options = list(pageLength = 12)) })
  
  output$plotfig3 <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4,4,2,2))
      input$evalfig3
      return(isolate(eval(parse(text=input$fig3plot))))
})
})
}
