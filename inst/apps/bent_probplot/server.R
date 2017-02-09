server = function(input, output, session) {
  
output$bleedplot <- renderPlot({
      par(mar = c(4,4,0,1))
      input$evalbleedplot
      return(isolate(eval(parse(text=input$bleedplot))))
})
}