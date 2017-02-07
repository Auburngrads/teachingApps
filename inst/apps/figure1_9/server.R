server = function(input, output, session) {
  
  library(SMRD)
  
output$printedcircuitboard <- DT::renderDataTable({ 
  
  DT::datatable(printedcircuitboard,
                options = list(pageLength = 12)) 
})
  
output$plotfig9 <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4,4,2,2))
      input$evalfig9
      return(isolate(eval(parse(text=input$fig9plot))))
})
}
