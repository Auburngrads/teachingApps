server = function(input, output, session) {

if(!getShinyOption("story"))  
output$sign <- renderUI({HTML(teachingApps::teachingApp(getShinyOption("appName")))})
  
  output$plotrepair <- renderPlot({
    par(mar = c(0,0,0,0))
    input$evalrepair
    return(isolate(eval(parse(text=input$repairplot))))
})
}