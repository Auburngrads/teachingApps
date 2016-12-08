server = function(input, output, session) {

if(!global$story)  
output$sign <- renderUI({HTML(teachingApps::teachingApp(global$appName))})
  
  output$plotrepair <- renderPlot({
    par(mar = c(0,0,0,0))
    input$evalrepair
    return(isolate(eval(parse(text=input$repairplot))))
})
}