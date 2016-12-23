server = function(input, output, session) {

if(!getShinyOption("story"))  
output$sign <- renderUI({HTML(teachingApps::teachingApp(getShinyOption("appName")))})
  
  output$plotreplace <- renderPlot({
    par(mar = c(0,0,0,0))
    input$evalreplace
    return(isolate(eval(parse(text=input$replaceplot))))
})
}