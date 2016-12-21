server = function(input, output, session) {

if(!getShinyOption("story"))
output$sign <- renderUI({HTML(teachingApps::teachingApp(getShinyOption("appName")))})
  
  output$plotreal <- renderPlot({
    par(oma = c(0,0,0,0), mar = c(4,4,2,2))
    input$evalreal    
    return(isolate(eval(parse(text=input$realplot))))
})
}