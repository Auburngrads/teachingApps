server = function(input, output, session) {
  
  output$berkint <- renderPlot({
      input$berks      
      return(isolate(eval(parse(text=input$berkint))))
})
}