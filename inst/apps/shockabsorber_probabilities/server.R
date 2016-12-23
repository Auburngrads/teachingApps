server = function(input, output, session) {

  output$sprob <- renderPlot({
      input$shockprobs
      return(isolate(eval(parse(text=input$shockprob))))
})
}