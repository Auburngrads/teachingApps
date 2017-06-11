server = function(input, output, session) {

  session$onFlush(function() teachingApps:::add_css())
  
  output$shurf <- renderPlot({
      input$shocksurfs
      return(isolate(eval(parse(text=input$shocksurf))))
})
}