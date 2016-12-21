server = function(input, output, session) {
  
output$plotbin <- renderPlot({
      input$evalbin
      return(isolate(eval(parse(text=input$binplot))))
})
}