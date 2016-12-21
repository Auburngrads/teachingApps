server = function(input, output, session) {

  output$squant <- renderPlot({
      input$shockquants
      return(isolate(eval(parse(text=input$shockquant))))
})
}