server = function(input, output, session) {
  
if(!getShinyOption("story"))    
output$sign <- renderUI({HTML(teachingApp(getShinyOption("appName")))})

  output$bleedplot <- renderPlot({
      par(mar = c(4,4,0,1))
      input$evalbleedplot
      return(isolate(eval(parse(text=input$bleedplot))))
})
}