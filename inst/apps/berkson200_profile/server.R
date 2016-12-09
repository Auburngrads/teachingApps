library(teachingApps)
server = function(input, output, session) {
  
if(!getShinyOptions("story"))    
output$sign <- renderUI({HTML(teachingApp(getShinyOptions("appName")))})

  output$berk200prof <- renderPlot({
      input$berk200profiles
      return(isolate(eval(parse(text=input$berkprofile200))))
})
}