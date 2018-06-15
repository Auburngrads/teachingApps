server = function(input, output, session) {

      output$chazoutput <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(5,4,2,2))
      input$chazeval
      return(isolate(eval(parse(text=input$chazace))))
})  
}