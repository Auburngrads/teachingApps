server = function(input, output, session) {

  output$samps <- renderPlot({
      par(mar = c(4,4,2,2))
      input$sampplot      
      return(isolate(eval(parse(text=input$samp))))
})
}