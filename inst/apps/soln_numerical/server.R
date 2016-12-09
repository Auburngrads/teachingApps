server = function(input, output, session) {

if(!getShinyOptions("story"))    
output$sign <- renderUI({HTML(teachingApps::teachingApp(getShinyOptions("appName")))})
  
output$mlexp2 <- renderPrint({
      par(family = 'serif', mar = c(4,4,1,2))
      input$mlexpnums
      return(isolate(eval(parse(text=input$mlexpnum))))
})
}