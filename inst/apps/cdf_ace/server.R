server = function(input, output, session) {

      output$cdfoutput <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(5,4,2,2))
      input$cdfeval
      return(isolate(eval(parse(text=input$cdface))))
})  
}