server = function(input, output, session) {

observeEvent(input$berks, {

  output$berkint <- renderPlot({
      
      return(isolate(eval(parse(text=input$berkint))))
})
})
}