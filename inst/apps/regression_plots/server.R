server = function(input, output, session) {

  output$plotreg <- renderPlot({
    
      par(oma = c(0,0,0,0), mar = c(4,4,2,2))
      input$evalreg
      return(isolate(eval(parse(text=input$regplot))))
})
}