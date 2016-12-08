server = function(input, output, session) {

if(!global$story)  
output$sign <- renderUI({HTML(teachingApps::teachingApp(global$appName))})
  
  output$plotreplace <- renderPlot({
    par(mar = c(0,0,0,0))
    input$evalreplace
    return(isolate(eval(parse(text=input$replaceplot))))
})
}