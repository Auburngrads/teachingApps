server = function(input, output, session) {
  
if(!getShinyOption("story"))  
output$sign <- renderUI({HTML(teachingApps::teachingApp(getShinyOption("appName")))})
  
  output$berkint <- renderPlot({
      input$berks      
      return(isolate(eval(parse(text=input$berkint))))
})
}