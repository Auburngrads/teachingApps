server = function(input, output, session) {

  session$onFlush(function() teachingApps::add_css())
  
  output$squant <- renderPlot({
      input$shockquants
      return(isolate(eval(parse(text=input$shockquant))))
})
}