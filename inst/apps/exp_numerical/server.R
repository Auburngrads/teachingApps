server = function(input, output, session) {

if(!global$story)    
output$sign <- renderUI({HTML(teachingApps::teachingApp(global$appName))})
  
output$mlexp2 <- renderPrint({
      par(family = 'serif', mar = c(4,4,1,2))
      input$mlexpnums
      return(isolate(eval(parse(text=input$mlexpnum))))
})
}