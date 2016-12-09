server = function(input, output, session) {
  
if(!getShinyOptions("story"))  
output$sign <- renderUI({HTML(teachingApps::teachingApp(getShinyOptions("appName")))})
  
  output$berkint <- renderPlot({
      input$berks      
      return(isolate(eval(parse(text=input$berkint))))
})
}