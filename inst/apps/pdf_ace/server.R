server = function(input, output, session) {

      output$pdfoutput <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(5,4,2,2))
      input$pdfeval
      return(isolate(eval(parse(text=input$pdface))))
})  
}