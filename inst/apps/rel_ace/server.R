server = function(input, output, session) {

      output$reloutput <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(5,4,2,2))
      input$releval
      return(isolate(eval(parse(text=input$relace))))
})  
}