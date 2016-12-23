server = function(input, output, session) {

  output$shurf <- renderPlot({
      input$shocksurfs
      return(isolate(eval(parse(text=input$shocksurf))))
})
}