server = function(input, output, session) {

if(!global$story)  
output$sign <- renderUI({HTML(teachingApps::teachingApp(global$appName))})
  
output$ploteventplots <- renderPlot({
      input$evaleventplots      
      return(isolate(eval(parse(text=input$eventplots))))
})
}