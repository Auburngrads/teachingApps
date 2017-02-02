server = function(input, output, session) {

output$ploteventplots <- renderPlot({
      input$evaleventplots      
      return(isolate(eval(parse(text=input$eventplots))))
})
}