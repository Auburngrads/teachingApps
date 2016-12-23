server = function(input, output, session) {

observeEvent(input$evalcensor, { 
  
output$plotcensor <- renderPlot({
      
      return(isolate(eval(parse(text=input$censorplot))))
})
})
}