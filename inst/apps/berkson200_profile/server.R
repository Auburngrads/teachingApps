library(teachingApps)
server = function(input, output, session) {
  
if(!getShinyOption("story"))    
output$sign <- renderUI({HTML(teachingApp(getShinyOption("appName")))})

  output$berk200prof <- renderPlot({
      input$berk200profiles
      return(isolate(eval(parse(text=input$berkprofile200))))
})
}