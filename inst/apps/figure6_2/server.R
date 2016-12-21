server = function(input, output, session) {
  
  output$norm <- renderPlot({
      par(mar = c(4,4,2,2))
      input$evalplots
      return(isolate(eval(parse(text=input$plots))))
})
}