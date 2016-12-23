server = function(input, output, session) {
  
if(!getShinyOption("story"))    
output$sign <- renderUI({HTML(teachingApp(getShinyOption("appName")))})

  output$exp <- renderPlot({
      par(mar = c(4,4,2,2))
      input$evalplots      
      return(isolate(eval(parse(text=input$plots))))
})
}