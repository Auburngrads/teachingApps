server = function(input, output, session) {

      output$quanoutput <- renderPlot({
      par(oma = c(0,0,0,0), mar = c(5,4,2,2))
      input$quaneval
      return(isolate(eval(parse(text=input$quanace))))
})  
}