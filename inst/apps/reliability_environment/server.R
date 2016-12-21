server = function(input, output, session) {

 output$plotenvir <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(4,4,2,2))
      input$evalenvir
      return(isolate(eval(parse(text=input$fig1plot))))
})
}