server = function(input, output, session) {

if(!global$story)    
output$sign <- renderUI({HTML(teachingApps::teachingApp(global$appName))})
  
output$plotlike <- renderPlot({
      par(family = 'serif', mar = c(4,4,1,2))
      input$evallike      
      return(isolate(eval(parse(text=input$likeplot))))
})
}