server = function(input, output, session) {

output$plotlike2 <- renderPlot({
      par(family = 'serif', mar = c(4,4,1,2))
      input$evallike2      
      return(isolate(eval(parse(text=input$likeplot2))))
})
}