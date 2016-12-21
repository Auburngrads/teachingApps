server = function(input, output, session) {
  
  observeEvent(input$evalfig1, { 
    
output$plotfig1 <- renderPlot({
      
      return(isolate(eval(parse(text=input$fig1plot))))
})
})
}