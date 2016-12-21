server = function(input, output, session) {
  
observeEvent(input$evalfig5, { 
  
  output$plotfig5 <- renderPlot({
      
      return(isolate(eval(parse(text=input$fig5plot))))
})
})
