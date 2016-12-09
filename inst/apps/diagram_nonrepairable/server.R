server = function(input, output, session) {

if(!getShinyOptions("story"))  
output$sign <- renderUI({HTML(teachingApps::teachingApp(getShinyOptions("appName")))})
  
  output$plotreplace <- renderPlot({
    par(mar = c(0,0,0,0))
    input$evalreplace
    return(isolate(eval(parse(text=input$replaceplot))))
})
}