server = function(input, output, session) {

if(!getShinyOption("story"))  
output$sign <- renderUI({HTML(teachingApps::teachingApp(getShinyOption("appName")))})
  
output$ploteventplots <- renderPlot({
      input$evaleventplots      
      return(isolate(eval(parse(text=input$eventplots))))
})
}