server = function(input, output, session) {

if(!getShinyOptions("story"))  
output$sign <- renderUI({HTML(teachingApps::teachingApp(getShinyOptions("appName")))})
  
output$ploteventplots <- renderPlot({
      input$evaleventplots      
      return(isolate(eval(parse(text=input$eventplots))))
})
}