server = function(input, output, session) {

if(!getShinyOptions("story"))  
output$sign <- renderUI({HTML(teachingApps::teachingApp(getShinyOptions("appName")))})
  
  output$plotrepair <- renderPlot({
    par(mar = c(0,0,0,0))
    input$evalrepair
    return(isolate(eval(parse(text=input$repairplot))))
})
}