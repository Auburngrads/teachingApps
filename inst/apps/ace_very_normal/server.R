server = function(input, output, session) {
  
if(!getShinyOptions("story"))    
output$sign <- renderUI({HTML(teachingApp(getShinyOptions("appName")))})

  output$exp <- renderPlot({
      par(mar = c(4,4,2,2))
      input$evalplots      
      return(isolate(eval(parse(text=input$plots))))
})
}