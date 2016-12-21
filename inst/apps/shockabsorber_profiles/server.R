server = function(input, output, session) {

  output$shorf <- renderPlot({
      input$shockprofs
      return(isolate(eval(parse(text=input$shockprof))))
})
}