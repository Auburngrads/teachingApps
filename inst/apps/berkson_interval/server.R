server = function(input, output, session) {
  
  output$sign <- renderUI({HTML(teachingApps::teachingApp(source('args.R')[[1]]$appName))})
  
  output$berkint <- renderPlot({
      input$berks      
      return(isolate(eval(parse(text=input$berkint))))
})
}