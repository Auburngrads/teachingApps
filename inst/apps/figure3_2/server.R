server = function(input, output, session) {
  
output$plot3.2 <- renderPlot({
      input$eval3.2
      return(isolate(eval(parse(text=input$npplot))))
})
}