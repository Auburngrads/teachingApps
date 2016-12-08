server = function(input, output, session) {
  
if(!global$story)    
output$sign <- renderUI({HTML(teachingApp(global$appName))})

  output$exp <- renderPlot({
      par(mar = c(4,4,2,2))
      input$evalplots      
      return(isolate(eval(parse(text=input$plots))))
})
}