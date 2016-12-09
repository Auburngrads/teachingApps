server = function(input, output, session) {

if(!getShinyOptions("story"))    
output$sign <- renderUI({HTML(teachingApps::teachingApp(getShinyOptions("appName")))})
  
output$plotlike <- renderPlot({
      par(family = 'serif', mar = c(4,4,1,2))
      input$evallike      
      return(isolate(eval(parse(text=input$likeplot))))
})
}