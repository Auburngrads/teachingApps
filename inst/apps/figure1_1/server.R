server = function(input, output, session) {
  
  library(SMRD)
  
output$lzbearing <- DT::renderDataTable({ 
    
    DT::datatable(lzbearing,
                  options = list(pageLength = 12)) 
})
  
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
}
