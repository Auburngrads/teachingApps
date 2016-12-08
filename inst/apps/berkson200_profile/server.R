library(teachingApps)
server = function(input, output, session) {
  
if(!global$story)    
output$sign <- renderUI({HTML(teachingApp(global$appName))})

  output$berk200prof <- renderPlot({
      input$berk200profiles
      return(isolate(eval(parse(text=input$berkprofile200))))
})
}