server = function(input, output, session) {

output$plotcensor <- renderPlot({
      input$evalcensor
      return(isolate(eval(parse(text=input$censorplot))))
})
}