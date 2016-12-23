server = function(input, output, session) {

if(!getShinyOption("story"))    
output$sign <- renderUI({HTML(teachingApp(getShinyOption("appName")))})
  
output$plotlike2 <- renderPlot({
      par(family = 'serif', mar = c(4,4,1,2))
      input$evallike2      
      return(isolate(eval(parse(text=input$likeplot2))))
})
}