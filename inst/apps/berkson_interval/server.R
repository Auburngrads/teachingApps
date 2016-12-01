server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp(global$appName))})
  
  output$berkint <- renderPlot({
      input$berks      
      return(isolate(eval(parse(text=input$berkint))))
})
}