server = function(input, output, session) {
  
output$plotfig56 <- renderPlot({
      input$evalfig56
      return(isolate(eval(parse(text=input$fig56plot))))
})
}