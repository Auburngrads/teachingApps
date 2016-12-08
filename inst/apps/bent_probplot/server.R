server = function(input, output, session) {
  
if(!global$story)    
output$sign <- renderUI({HTML(teachingApp(global$appName))})

  output$bleedplot <- renderPlot({
      par(mar = c(4,4,0,1))
      input$evalbleedplot
      return(isolate(eval(parse(text=input$bleedplot))))
})
}