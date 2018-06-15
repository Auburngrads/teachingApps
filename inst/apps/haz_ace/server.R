server = function(input, output, session) {

      output$hazoutput <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(5,4,2,2))
      input$hazeval
      return(isolate(eval(parse(text=input$hazace))))
})  
}