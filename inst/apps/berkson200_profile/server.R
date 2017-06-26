server = function(input, output, session) {
  
  output$berk200prof <- renderPlot({
      input$berk200profiles
      return(isolate(eval(parse(text=input$berkprofile200))))
})
}