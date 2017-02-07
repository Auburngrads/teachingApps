server = function(input, output, session) {
  
  library(SMRD)
  
output$lfp1370 <- DT::renderDataTable({ 
    
    DT::datatable(lfp1370,
                  options = list(pageLength = 12)) 
})
  
output$plotfig3 <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4,4,2,2))
      input$evalfig3
      return(isolate(eval(parse(text=input$fig3plot))))
})
}